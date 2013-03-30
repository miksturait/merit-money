# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kudo do
    value 1
    comment "thanks for keeping customer happy"
    association :giver, factory: :user
    association :receiver, factory: :user
  end
end
