# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :allowed_user, :class => 'AllowedUser' do
    name "MyString"
    email "MyString"
  end
end
