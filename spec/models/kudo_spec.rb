require 'spec_helper'

describe Kudo do
  it { should have_db_column(:value).of_type(:integer) }
  it { should have_db_column(:comment).of_type(:text) }

  it { should delegate_method(:giver).to(:weekly_kudo) }

  it { should belong_to(:receiver).class_name("User") }
  it { should belong_to(:weekly_kudo).class_name("WeeklyKudo") }

  it { should ensure_inclusion_of(:value).in_range(1..20).
                  with_message("you are not allowed to go beyond kudos limit") }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:receiver_id) }
  it { should validate_presence_of(:weekly_kudo_id) }
  it { should allow_value(nil, "").for(:comment) }

  context "custom validation" do
    subject(:kudo) { build(:kudo) }

    it { should be_valid }

    context "setting receiver as same as giver" do
      before(:each) do
        kudo.receiver = kudo.giver
        kudo.valid?
      end

      it { should_not be_valid }
      it { should have(1).errors }
    end
  end

  context "giving and receiving kudo" do
    context "green field" do
      let!(:tom) { create(:user, email: 'tom@selleo.com', name: 'Tom') }
      let!(:bart) { create(:user, email: 'bart@selleo.com', name: 'Bart') }

      before do
        Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))
      end

      after do
        Timecop.return
      end

      context "giving kudo" do

        let!(:kudo) { tom.thanks_to_user(bart, {value: 3, comment: 'for sending feedback to the team'}) }

        it { expect(Kudo.count).to eq(1) }
        it { expect(kudo).to eq(tom.kudos.first) }
        it { expect(kudo.value).to eq(3) }
        it { expect(kudo.comment).to_not be_blank }

        context "giver" do
          it { expect(tom).to have(1).kudos }
          it { expect(tom).to have(0).kudos_received }

          let(:weekly_kudo) { kudo.weekly_kudo }
          it { expect(weekly_kudo.kudos_left).to eq(17) }

          let(:week) { weekly_kudo.week }
          it { expect(week).to eq(Week.current) }
        end

        context "receiver" do
          it { expect(bart).to have(0).kudos }
          it { expect(bart).to have(1).kudos_received }
        end
      end

      context "giving more then you have is not allowed" do
        let!(:kudo) { tom.thanks_to_user(bart, {value: 15, comment: 'for sending feedback to the team'}) }

        it { expect { tom.thanks_to_user(bart, {value: 6}) }.to_not change { Kudo.count } }
      end

    end
  end

  context "week after week - last week kudo stats recalculation" do
    after do
      Timecop.return
    end

    let(:tom) { create(:user, email: 'tom@selleo.com', name: 'Tom') }
    let(:bart) { create(:user, email: 'bart@selleo.com', name: 'Bart') }
    let(:simon) { create(:user, email: 'simon@selleo.com', name: 'Simon') }
    let(:radek) { create(:user, email: 'radek@selleo.com', name: 'Radek') }

    before do
      Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))

      tom.thanks_to_user(bart, {value: 3})
      tom.thanks_to_user(bart, {value: 2})
      tom.thanks_to_user(bart, {value: 1})
      simon.thanks_to_user(bart, {value: 5})
      simon.thanks_to_user(bart, {value: 1})

      simon.thanks_to_user(tom, {value: 1})
      radek.thanks_to_user(bart, {value: 1})

      simon.thanks_to_user(radek, {value: 1})
      bart.thanks_to_user(radek, {value: 1})

      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))

      simon.thanks_to_user(bart, {value: 8})
    end

    let(:bart_weekly_kudo) { bart.current_weekly_kudo }
    let(:bart_last_week_kudos) { bart_weekly_kudo.last_week_kudos_received }
    let(:bart_total_kudos) { bart_weekly_kudo.up_to_last_week_total_kudos_received }

    it { expect(bart_last_week_kudos).to eq(13) }
    it { expect(bart_total_kudos).to eq(13) }

    let(:radek_weekly_kudo) { radek.current_weekly_kudo }
    let(:radek_last_week_kudos) { radek_weekly_kudo.last_week_kudos_received }
    let(:radek_total_kudos) { radek_weekly_kudo.up_to_last_week_total_kudos_received }

    it { expect(radek_last_week_kudos).to eq(2) }
    it { expect(radek_total_kudos).to eq(2) }

    let(:tom_weekly_kudo) { tom.current_weekly_kudo }
    let(:tom_last_week_kudos) { tom_weekly_kudo.last_week_kudos_received }
    let(:tom_total_kudos) { tom_weekly_kudo.up_to_last_week_total_kudos_received }

    it { expect(tom_last_week_kudos).to eq(1) }
    it { expect(tom_total_kudos).to eq(1) }
  end

  pending "will be done in milestone: BackEnd-3#sks-35" do
    context "there is two weeks gap between current week and last week that user have weekly kudo" do
      # it should recreate all missing weekly kudos up to current week
    end
  end

  describe "comment format" do
    let(:kudo) { build(:kudo, value: 3, comment: "one, two")}

    it { expect(kudo.ember_comment_info).to eq({value: 3, comment: "one, two"})}
  end
end
