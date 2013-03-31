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
      it { expect(week).to eq(@last_week)}
    end
  end
end
