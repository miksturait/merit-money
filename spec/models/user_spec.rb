require 'spec_helper'

describe User do

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:with_company_since).of_type(:date) }
  it { should have_db_column(:days_off_left).of_type(:integer) }

  it { should have_many(:kudos).through(:weekly_kudos) }
  it { should have_many(:kudos_received).class_name("Kudo") }


  context "weekly kudo for current week" do
    let(:tom) { create(:user, name: 'Tom') }
    let!(:weekly_kudo) { WeeklyKudo.current(tom) }

    it { expect(weekly_kudo).to eq(tom.current_weekly_kudo) }
  end

end
