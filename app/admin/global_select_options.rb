ActiveAdmin.register GlobalSelectOption do
  # filter :name
  # filter :vehicle_type
  config.filters = false
  menu priority: 14
  # filter :vehicle_type, label: 'locale', as: :select, collection: LANG, :class=>'asdfasd'

  sidebar :locales do
    render partial: 'admin/global_select_options/search'
  end

  actions :all
  controller do
    def update
      
      if params[:id]
        @select = GlobalSelectOption.find(params[:id])
      else
        @select = GlobalSelectOption.new
      end
      if opts_en = params[:global_select_option].delete(:options_en).presence
        @select.options['en'] = opts_en.split("\n").compact.map(&:strip)
      end
      if opts_fr = params[:global_select_option].delete(:options_fr).presence
        @select.options['fr'] = opts_fr.split("\n").compact.map(&:strip)
      end
      if opts_br = params[:global_select_option].delete(:options_br).presence
        @select.options['br'] = opts_br.split("\n").compact.map(&:strip)
      end
      if opts_de = params[:global_select_option].delete(:options_de).presence
        @select.options['de'] = opts_de.split("\n").compact.map(&:strip)
      end
      if opts_hi = params[:global_select_option].delete(:options_hi).presence
        @select.options['hi'] = opts_hi.split("\n").compact.map(&:strip)
      end

      if @select.update_attributes(params[:global_select_option])
        redirect_to admin_global_select_option_url(@select)
      else
        redirect_to admin_global_select_options_url
      end
    end

    def get_locale
      @global = GlobalSelectOption.where("options like ?","%#{params[:locale]}%").order('created_at DESC')
      respond_to do |format|
        format.js   # renders show.js.erb
      end
    end

    def update_global_options
      @gso = GlobalSelectOption.find(params[:update_value])
      @gso.options[params[:locale]][params[:indexId].to_i] = params[:value]
      @gso.save!
      redirect_to root_url
    end
    alias :create :update
  end

  member_action :duplicate, :method => :post do
    select = GlobalSelectOption.find(params[:id])
    redir = lambda do |msg_hash = {}|
      redirect_to({:action => :index}, msg_hash)
    end
    if select.blank?
      redir.call(:alert => 'There was an error')
      break
    end
    vehicle_type = select.vehicle_type
    name = select.name
    exists = GlobalSelectOption.where('vehicle_type != :type', :type => vehicle_type).
      where(:name => name).any?
    if exists
      redir.call(:alert => 'a select option with that name and vehicle type already exists')
      break
    end
    new = GlobalSelectOption.new(:vehicle_type => Vehicle::TYPES.reject { |type| type == vehicle_type }.first)
    new.update_attributes(select.attributes.except('vehicle_type', 'id', 'created_at', 'updated_at'))
    redir.call(:notice => 'successfully duplicated')
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :vehicle_type, as: :radio, collection: Vehicle::TYPES, selected: global_select_option.vehicle_type
      f.input :options_en, as: :text
      f.input :options_fr, as: :text
      f.input :options_br, as: :text
      f.input :options_de, as: :text
      f.input :options_hi, as: :text
    end

    f.buttons
  end

  show do
    panel 'Global Select Option Details' do
      attributes_table_for(global_select_option) do
        row :name do |select|
          if (alias_key = select.name.presence.try(:to_sym)) && (name_display = GlobalSelectOption::ALIASES[select.vehicle_type][alias_key])
            name_display
          else
            select.name
          end

        end
        row :vehicle_type
        row :options_en do
          ul do
            (global_select_option.options['en'] || []).each do |opt|
              li { opt }
            end
          end
        end
        row :options_fr do
          ul do
            (global_select_option.options['fr'] || []).each do |opt|
              li { opt }
            end
          end
        end
        row :options_br do
          ul do
            (global_select_option.options['br'] || []).each do |opt|
              li { opt }
            end
          end
        end

        row :options_de do
          ul do
            (global_select_option.options['de'] || []).each do |opt|
              li { opt }
            end
          end
        end

        row :options_hi do
          ul do
            (global_select_option.options['hi'] || []).each do |opt|
              li { opt }
            end
          end
        end

      end
    end
  end

  index do
    column :name do |select|
      if (alias_key = select.name.presence.try(:to_sym)) && (name_display = GlobalSelectOption::ALIASES[select.vehicle_type][alias_key])
        name_display
      else
        select.name
      end
    end
    column :vehicle_type
    column 'options (en)' do |select|
      ul do
        (select.options['en'] || []).each do |opt|
          li { opt }
        end
      end
    end

    column 'options (language)' do |select|
      ul do
        (select.options['en'] || []).each do |opt|
          li { opt }
        end
      end
    end

    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end

  scope :all, default: true
  scope :cars do |selects|
    selects.for_cars
  end
  scope :bikes do |selects|
    selects.for_bikes
  end

  controller { with_role :admin_user }
end
