ActiveAdmin.register TranslationText do
  menu priority: 12
  menu :label => "Translations"
  menu false
  actions :index, :new, :create, :edit, :update, :destroy

  filter :locale, label: 'locale', as: :select, collection: Proc.new { TranslationText.pluck(:locale).uniq }
  filter :text, label: 'text'

  index do
    column :locale
    column 'Key' do |translation_text|
      link_to translation_text.translation_key.human_key, edit_admin_translation_text_path(translation_text), title: translation_text.translation_key.key
    end
    column :text
    default_actions
  end
  form do |f|
    f.inputs do
      f.input :translation_key_id,
              as: :select,
              collection: TranslationKey.all,
              member_value: :id,
              member_label: :human_key,
              include_blank: false
      f.input :text
      f.input :locale, as: :select, collection: (TranslationText.pluck(:locale).uniq + UnfoundTranslation.pluck(:locale).uniq).uniq
    end

    f.buttons
  end
end

