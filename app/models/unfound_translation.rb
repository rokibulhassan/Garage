class UnfoundTranslation

  include TranslationHumanKey
  attr_reader :locale, :key


  def initialize args
    @locale, @key = *args
  end

  def self.all
    MissingTranslationLogger.unfound_translations
  end

  def self.for *names
    all.inject([]) do |acc, unfound_translation|
      acc << unfound_translation if unfound_translation.for_attributes?(names)

      acc
    end
  end

  def self.pluck name
    all.map &name
  end

  def for_attributes? attributes
    attributes.any? { |attribute| key.slice(attribute).present? }
  end
end