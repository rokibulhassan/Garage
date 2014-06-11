ActiveAdmin.register Brand do
  menu priority: 2

  decorate_with BrandAdminDecorator

  filter :name
  filter :by_type, as: :check_boxes, collection: Vehicle::TYPES
  actions :all, except: :new

  form do |f|
    f.inputs do
      f.input :name
      f.input :vehicle_types, as: :check_boxes, collection: Vehicle::TYPES
      f.input :approval_status, :as => :select, :collection => AdminValidatable::STATUSES.map {|s| [s, s] }, :selected => f.object.send(:_approval_status)
    end

    f.buttons
  end

  show do
    panel 'Brand Details' do
      attributes_table_for brand do
        row :name
        row :vehicle_types
        row('Approval Status') { status_tag(brand.send(:_approval_status), (brand.accepted? ? :ok : :error)) }
      end
    end
  end

  scope :all, :default => true do
    Brand.order('id DESC')
  end

  scope :accepted do
    Brand.accepted.order('id DESC')
  end
  scope :rejected do
    Brand.rejected.order('id DESC')
  end
  scope :pending do
    Brand.pending.order('id DESC')
  end

  index do
    column :name
    column :vehicle_types
    column 'Approval Status' do |brand|
      status_tag(brand.send(:_approval_status), (brand.accepted? ? :ok : :error))
    end
    default_actions
  end


  controller { with_role :admin_user }
end

