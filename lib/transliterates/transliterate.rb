module Transliterate
  extend ActiveSupport::Concern

  module ClassMethods
    def transliterate(*columns)
      define_method("translated_columns") do
        columns
      end

      columns.each do |column|
        define_method("#{column}=") do |value|
          if value
            transliterated = I18n.transliterate value
            write_attribute column, transliterated
            TranslationKey.find_or_create_by_key(translation_key_of(column)).translations.create(text: value, locale: FastGettext.locale)
          end
        end

        define_method("__#{column}") do
          key = translation_key_of column
          key.present? ? FastGettext.s_(key) : nil
        end

        define_method("#{column}_translations") do
          key = TranslationKey.find_by_key translation_key_of(column)
          key.present? ? key.translations : TranslationText.scoped
        end
      end
    end
  end

  def translation_key_of attribute_name
    value = self.send attribute_name
    value.nil? ? nil : "model|#{self.class.to_s.downcase}|#{attribute_name}|#{value}"
  end
end
