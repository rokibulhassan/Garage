class TranslationTextObserver < ActiveRecord::Observer
  def after_create translation
    translation.send :expire_cache

    MissingTranslationLogger.remove translation.translation_key, translation.locale
  end
end
