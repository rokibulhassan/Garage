ActiveAdmin.register Model do
  menu priority: 4

  actions :all, except: :new

  filter :vehicle_type, as: :select, collection: Vehicle::TYPES
  filter :brand, as: :select, collection: Proc.new {
    relation = Brand.select([:id, :name]).joins(:models).order(:name).group(:id, :name)
    params['q'].try(:[], 'vehicle_type_eq').present? ? relation.where(models: { vehicle_type: params['q']['vehicle_type_eq']}) : relation
  }

  filter :name

  controller do
    def scoped_collection
      Model.includes(:brand)
    end
  end

  index do
    column :id
    column :brand, sortable: 'brands.name'
    column :name
    column :vehicle_type
    column 'Approval Status' do |model|
      status_tag(model.send(:_approval_status), (model.accepted? ? :ok : :error))
    end
    default_actions
  end

  show do
    panel 'Model Details' do
      attributes_table_for model do
        row :id
        row :brand
        row :name
        row :vehicle_type
        row 'Approval Status' do
          status_tag(model.send(:_approval_status), (model.accepted? ? :ok : :error))
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :approval_status, :as => :select, :collection => AdminValidatable::STATUSES.map {|s| [s, s] }, :selected => f.object.send(:_approval_status)
    end

    f.actions
  end

  scope :all, :default => true do
    Model.order('id DESC')
  end

  scope :accepted do
    Model.accepted.order('id DESC')
  end
  scope :rejected do
    Model.rejected.order('id DESC')
  end
  scope :pending do
    Model.pending.order('id DESC')
  end

end
