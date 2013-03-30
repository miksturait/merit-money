require 'spec_helper'

describe Kudo do
  it { should have_db_column(:value).of_type(:integer) }
  it { should have_db_column(:comment).of_type(:text) }

  it { should delegate_method(:giver).to(:weekly_kudo) }

  it { should belong_to(:receiver).class_name("User") }
  it { should belong_to(:weekly_kudo).class_name("WeeklyKudo") }

  it { should ensure_inclusion_of(:value).in_range(1..20) }
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

end
