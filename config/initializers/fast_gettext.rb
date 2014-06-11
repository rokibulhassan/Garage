# db access is cached <-> only first lookup hits the db
require "fast_gettext/translation_repository/db"
FastGettext::TranslationRepository::Db.require_models #load and include default models

repos = [
    FastGettext::TranslationRepository.build('attribute_values', type: :db, model: TranslationKey),
    FastGettext::TranslationRepository.build('logger', type: :logger, callback:  lambda {|unfound| MissingTranslationLogger.call unfound})
]

FastGettext.add_text_domain 'app', type: :chain, chain: repos
FastGettext.default_text_domain = 'app'

TranslationKey.send :include, TranslationHumanKey