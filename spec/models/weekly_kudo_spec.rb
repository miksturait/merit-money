require 'spec_helper'

describe WeeklyKudo do
  # if the last week is within the current fussion
  it { should have_db_column(:kudos_left).of_type(:integer) }
  it { should ensure_inclusion_of(:kudos_left).in_range(0..20) }

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
end
