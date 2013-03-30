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
end
