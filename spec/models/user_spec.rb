require 'spec_helper'

describe User do

  it { should have_db_column(:email).of_type(:string)}
  it { should have_db_column(:name).of_type(:string)}
  it { should have_db_column(:with_company_since).of_type(:date)}
  it { should have_db_column(:days_off_left).of_type(:integer)}

  it { should have_many(:kudos_send).class_name("Kudo") }
  it { should have_many(:kudos_received).class_name("Kudo") }

end
