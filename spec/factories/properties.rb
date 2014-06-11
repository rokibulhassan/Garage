FactoryGirl.define do
  factory :property_definition do
    sequence(:name) {|n| "property #{n}"}
    comparator "Comparator::Base"
    unit_type "length"
  end

  factory :version_property do
    association :version
    value "1000"
    ignore do
      name "property"
      unit_type "length"
      comparator "Comparator::Base"
    end

    before :create do |version_property, evaluator|
      existing = PropertyDefinition.find_by_name(evaluator.name)

      version_property.property_definition = existing || FactoryGirl.create(:property_definition, name: evaluator.name, unit_type: evaluator.unit_type, comparator: evaluator.comparator)
    end
  end

  factory :modification_property do
    association :modification
    value "1000"
    ignore do
      name "property"
      unit_type "length"
      comparator "Comparator::Base"
    end

    before :create do |modification_property, evaluator|
      existing = PropertyDefinition.find_by_name(evaluator.name)

      modification_property.property_definition = existing || FactoryGirl.create(:property_definition, name: evaluator.name, comparator: evaluator.comparator, unit_type: evaluator.unit_type)
    end
  end
end

