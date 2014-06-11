module ChosenJS
    def select_from_chosen(item_text, options)
      page.find_field(options[:from]).select item_text
      page.execute_script("$('##{options[:from]}').trigger('liszt:updated');")
    end

    def add_value_to_chosen(item_text, options)
      page.execute_script("$('#{options[:from]}').data('chosen').create_option('#{item_text}');")
    end

end

World(ChosenJS)
