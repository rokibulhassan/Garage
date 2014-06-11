FactoryGirl.define do
  factory :comparison_table do
    sequence(:label) { |n| "Comparison table #{n}" }
    association :user
  end
end
