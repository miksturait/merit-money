require 'spec_helper'

describe User do

  it { should have_db_column(:email).of_type(:string)}
  it { should have_db_column(:first_name).of_type(:string)}
  it { should have_db_column(:last_name).of_type(:string)}
  it { should have_db_column(:with_company_since).of_type(:date)}
  it { should have_db_column(:days_off_left).of_type(:integer)}

end
