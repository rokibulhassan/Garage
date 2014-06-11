module ApplicationHelper
  def seed_data(property, template_name, locals, options = {})
    options.reverse_merge!(prefix: 'window.Seeds')

    file = Rails.root.join('app', 'views', template_name)
    json = render(file: file, formats: [:json], handlers: [:jbuilder], locals: locals)
    key  = "#{options[:prefix]}.#{property}"
    code = "#{key} = #{json};\n"

    javascript_tag { raw(code) }
  end

  # Replace json.partial!('/vehicle_types/type.json.jbuilder', type: type)
  # Which throw deprecation warnings "Passing a template handler in the template name is deprecated."
  def json_partial!(json, template, locals)
    json.partial!(partial: template, formats: [:json], handlers: [:jbuilder], locals: locals)
  end
end
