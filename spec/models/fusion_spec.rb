require 'spec_helper'

describe Fusion do

  it { should have_db_column(:total_working_hours).of_type(:integer) }
  it { should have_db_column(:total_fusion_budget).of_type(:integer) }
  it { should have_db_column(:start_at).of_type(:datetime) }
  it { should have_db_column(:end_at).of_type(:datetime) }

  it { should have_many(:weeks).class_name("Week") }
  it { should validate_presence_of(:start_at) }
  it { should ensure_inclusion_of(:total_fusion_budget).in_range(40_000..80_000).allow_nil(true) }

  context "current fusion" do
    context "when not any defined yet" do

      it "new fusion should be created" do
        expect { Fusion.current }.to change { Fusion.count }.from(0).to(1)
      end

      context "new fusion have default values as" do
        before do
          Timecop.freeze(Time.parse('2013-03-31 13:15 UTC'))
        end

        after do
          Timecop.return
        end

        subject(:fusion) { Fusion.current }

        it { expect(fusion.start_at).to eq(Time.parse('2013-03-25 00:00 UTC')) }
        it { expect(fusion.end_at).to be_nil }
        it { expect(fusion.total_working_hours).to be_nil }
        it { expect(fusion.total_fusion_budget).to be_nil }
      end
    end

    context "when two are defined, and last have end date nil" do
      before do
        create(:fusion,
               start_at: Time.parse('2013-01-01 00:00 UTC'),
               end_at: Time.parse('2013-03-31 23:59:59 UTC'))
        Timecop.freeze(Time.parse('2013-05-08 13:15 UTC'))
      end

      after do
        Timecop.return
      end

      let!(:last_fusion) { create(:fusion, start_at: Time.parse('2013-04-01 00:00 UTC')) }

      it { expect(Fusion.current).to eq(last_fusion) }
    end

    context "when one is defined and end data is set" do
      before do
        Timecop.freeze(Time.parse('2013-05-08 13:15 UTC'))
      end

      after do
        Timecop.return
      end

      let!(:last_fusion) { create(:fusion,
                                 start_at: Time.parse('2013-01-01 00:00 UTC'),
                                 end_at: Time.parse('2013-03-31 22:59:59 UTC')) }

      let!(:fusion) { Fusion.current }

      it { expect(fusion).to_not eq(last_fusion) }
      # it is taking last fusion end date, and starting based on that
      it { expect(fusion.start_at).to eq(Time.parse('2013-03-31 23:00 UTC')) }
      it { expect(fusion.end_at).to be_nil }
    end
  end
end
