FactoryGirl.define do
  factory :candidate do
    lottery
    sequence(:name) { |n| "candidate#{n}" }
    weight 1
    winner false
  end
end
