ActiveAdmin.register_page "Unfound Translations" do
  menu priority: 60
  menu false
  content do
    table class: 'index_table' do
      thead do
        tr do
          th :locale
          th :key
        end
      end

      UnfoundTranslation.for('model|version|body',
                             'model|version|transmission_type',
                             'model|version|transmission_numbers').each do |unfound_translation|
        tr id: unfound_translation.key.gsub('|', '_') do
          td(unfound_translation.locale)
          td do
            link_to unfound_translation.human_key,
                    new_admin_translation_text_path(translation_text: {translation_key_id: TranslationKey.find_or_create_by_key(unfound_translation.key).id,
                                                    locale: unfound_translation.locale}),
                    title: unfound_translation.key
          end
        end
      end
    end
  end
end