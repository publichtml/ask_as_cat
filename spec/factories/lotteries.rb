FactoryGirl.define do
  factory :lottery do
    sequence(:name) { |n| "lottery#{n}" }
    winners_count 5
    drawn false
  end
end
