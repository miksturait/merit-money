require 'spec_helper'

describe WeeklyKudo do
  # if the last week is within the current fussion
  it { should have_db_column(:kudos_left).of_type(:integer) }
  it { should validate_inclusion_of(:kudos_left).in_range(0..60) }

  it { should have_db_column(:last_week_kudos_received).of_type(:integer) }
  # since last fusion
  it { should have_db_column(:up_to_last_week_total_kudos_received).of_type(:integer) }
  # all hours worked from Monday to Sunday, except delayed hours,
  # rounded up to full hours count
  it { should have_db_column(:hours_worked).of_type(:integer) }

  it { should belong_to(:week) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:week_id) }
  it { should validate_presence_of(:user_id) }

  it { should have_many(:kudos) }


  context "current" do
    before do
      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))
    end

    after do
      Timecop.return
    end

    let(:simon) { create(:user, name: 'Simon', email: 'simon@selleo.com') }

    it { expect { WeeklyKudo.current(simon) }.to change { WeeklyKudo.count }.from(0).to(1) }

    context "attributes and side effect" do
      subject(:weekly_kudo) { WeeklyKudo.current(simon) }

      it { expect(weekly_kudo.user).to eq(simon) }
      it { expect(weekly_kudo.kudos_left).to eq(20) }
      it { expect(weekly_kudo.last_week_kudos_received).to eq(0) }
      it { expect(weekly_kudo.up_to_last_week_total_kudos_received).to eq(0) }
      it { expect(weekly_kudo.hours_worked).to be_nil }

      let(:week) { weekly_kudo.week }
      it { expect(week).to eq(Week.current) }

      let(:fusion) { week.fusion }
      it { expect(fusion).to eq(Fusion.current) }
    end


  end

  describe "trend" do

    after do
      Timecop.return
    end

    let!(:tom) { create(:user, email: 'tom@selleo.com', name: 'Tom') }
    let!(:bart) { create(:user, email: 'bart@selleo.com', name: 'Bart') }
    let!(:simon) { create(:user, email: 'simon@selleo.com', name: 'Simon') }
    let!(:radek) { create(:user, email: 'radek@selleo.com', name: 'Radek') }
    let!(:stevo) { create(:user, email: 'stevo@selleo.com', name: 'Stevo') }

    before do
      Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))

      # bart +13 -1 vs 0
      tom.thanks_to_user(bart, {value: 3})
      tom.thanks_to_user(bart, {value: 2})
      tom.thanks_to_user(bart, {value: 1})
      simon.thanks_to_user(bart, {value: 5})
      simon.thanks_to_user(bart, {value: 1})
      radek.thanks_to_user(bart, {value: 1})

      # tom +1 -6 vs 0
      simon.thanks_to_user(tom, {value: 1})

      # radek +3 -1 vs 0
      simon.thanks_to_user(radek, {value: 2})
      bart.thanks_to_user(radek, {value: 1})
      # simon -9 vs 0

      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))

      tom.current_weekly_kudo
      radek.current_weekly_kudo
    end

    let!(:bart_first_week_trend) { bart.current_weekly_kudo.trend }
    let!(:simon_first_week_trend) { simon.current_weekly_kudo.trend }


    it { expect(bart_first_week_trend).to eq('upward') }
    it { expect(simon_first_week_trend).to eq('steady') }

    context "a week later" do
      before do
        # bart +2 vs +13,0
        tom.thanks_to_user(bart, {value: 2})
        # tom +1 vs +1,0
        simon.thanks_to_user(tom, {value: 1})
        # radek +4 vs +3,0
        bart.thanks_to_user(radek, {value: 4})
        # simon +6 vs 0,0
        tom.thanks_to_user(simon, {value: 6})

        Timecop.freeze(Time.parse('2013-03-11 13:15 UTC'))
      end

      let!(:bart_second_week_trend) { bart.current_weekly_kudo.trend }
      let!(:simon_second_week_trend) { simon.current_weekly_kudo.trend }
      let!(:radek_second_week_trend) { radek.current_weekly_kudo.trend }
      let!(:tom_second_week_trend) { tom.current_weekly_kudo.trend }

      it { expect(bart_second_week_trend).to eq('downward') }
      it { expect(simon_second_week_trend).to eq('upward') }
      it { expect(radek_second_week_trend).to eq('upward') }
      it { expect(tom_second_week_trend).to eq('upward') }

      context "and one more, week later" do
        before do
          # bart +4 vs +2, +13
          tom.thanks_to_user(bart, {value: 6})
          # tom +2 vs +1, +1
          simon.thanks_to_user(tom, {value: 2})
          # radek +3 vs +4, +3
          bart.thanks_to_user(radek, {value: 3})
          # simon +4 vs +6, 0
          tom.thanks_to_user(simon, {value: 4})

          Timecop.freeze(Time.parse('2013-03-18 13:15 UTC'))
        end

        let!(:bart_third_week_trend) { bart.current_weekly_kudo.trend }
        let!(:simon_third_week_trend) { simon.current_weekly_kudo.trend }
        let!(:radek_third_week_trend) { radek.current_weekly_kudo.trend }
        let!(:tom_third_week_trend) { tom.current_weekly_kudo.trend }

        it { expect(bart_third_week_trend).to eq('downward') }
        it { expect(simon_third_week_trend).to eq('upward') }
        it { expect(radek_third_week_trend).to eq('steady') }
        it { expect(tom_third_week_trend).to eq('upward') }
      end
    end

  end
end
