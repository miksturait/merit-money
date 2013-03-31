# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fusion do
    start_at "2013-01-31 10:35:32"
    end_at nil
    total_working_hours 400
    total_fusion_budget 55_000
  end
end
