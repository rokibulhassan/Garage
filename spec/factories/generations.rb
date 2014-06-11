# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :generation do
    association :version
    generation "1-st"
    started_at 2010
    finished_at 2011
  end
end
