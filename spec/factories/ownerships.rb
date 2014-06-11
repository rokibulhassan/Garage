# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ownership do
    sequence(:status) {|n| Ownership::STATUSES[n%Ownership::STATUSES.length]}
    sequence(:owner_name) {|n| Ownership::OWNER_NAMES[n%Ownership::OWNER_NAMES.length]}
  end
end
