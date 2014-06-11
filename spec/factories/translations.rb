FactoryGirl.define do
  factory :translation_key do
    sequence(:key) {|n| "translation_key_#{n}"}
  end

  factory :translation_text do
    sequence(:text) {|n| "translation_text_#{n}"}
    locale 'en'
    association :translation_key

    trait :with_key do
      ignore do
        key ''
      end
      translation_key nil

      before(:create) do |translation_text, evaluator|
        translation_text.translation_key = TranslationKey.find_or_create_by_key(evaluator.key)
      end
    end
    factory :easy_translation, traits: [:with_key]
  end
end