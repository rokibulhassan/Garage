module TranslationHumanKey
  extend ActiveSupport::Concern

  NAME_MAPPING = {/^model\|version/ => 'car|model'}

  def human_key
    human_key = key
    NAME_MAPPING.each do |key_regexp, mapping_value|
      if key =~ key_regexp
        human_key = key.gsub key_regexp, mapping_value
        break
      end
    end

    human_key.split('|').join(' -> ')
  end
end