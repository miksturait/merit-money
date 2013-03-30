# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kudo do
    value 1
    comment "thanks for keeping customer happy"
    association :receiver, factory: :user
    weekly_kudo
  end
end
