require 'spec_helper'

describe Week do

  it { should have_db_column(:start_at).of_type(:datetime) }
  it { should have_db_column(:end_at).of_type(:datetime) }

  it { should have_many(:weekly_kudos) }
  it { should belong_to(:fusion) }

  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:fusion_id) }

  context "current and previous week discovery" do
    before do
      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))
    end

    after do
      Timecop.return
    end
    context "default values for current week" do
      let!(:fusion) { create(:fusion, start_at: Time.parse('2013-02-01 00:00 UTC')) }
      subject(:week) { Week.current }

      # beginning of the week is > Saturday midnight
      it { expect(week.start_at).
          to eq(Time.parse('2013-03-04 00:00 UTC')) }

      # end of the week is <= Saturday midnight week after start at
      it { expect(week.end_at).
          to eq(Time.parse('2013-03-10 23:59:59 UTC')) }

      it { expect(week.number).
          to eq("201310") }

      it { expect(week.fusion).
          to eq(fusion) }
    end

    context "fetching previous week" do
      before do
        Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))
        @last_week = Week.current

        Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))
        @current_week = Week.current
      end

      after do
        Timecop.return
      end

      subject(:week) { Week.previous }

      it { expect(Week.count).to eq(2) }
      it { expect(week).to eq(@last_week) }
    end
  end

  describe "top kudos" do

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

      # bart +13
      tom.thanks(bart, {value: 3})
      tom.thanks(bart, {value: 2})
      tom.thanks(bart, {value: 1})
      simon.thanks(bart, {value: 5})
      simon.thanks(bart, {value: 1})

      # tom +1
      simon.thanks(tom, {value: 1})
      radek.thanks(bart, {value: 1})

      # radek +3
      simon.thanks(radek, {value: 2})
      bart.thanks(radek, {value: 1})

      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))
    end
    let(:last_week) { Week.previous }

    describe "collectors", :focus do
      let(:top_kudos_collectors) { last_week.top_kudos_collectors }

      it { expect(last_week).to have(3).top_kudos_collectors }
      it { expect(top_kudos_collectors).to_not include(simon, stevo) }
    end

    describe "hamsters" do

    end
  end
end
