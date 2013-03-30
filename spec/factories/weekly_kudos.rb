# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weekly_kudo do
    kudos_left 20
    last_week_kudos_received 1
    up_to_last_week_total_kudos_received 1
    hours_worked 1
    user
    week
  end
end
