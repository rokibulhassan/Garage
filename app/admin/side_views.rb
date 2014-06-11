ActiveAdmin.register SideView do
  menu priority: 8

  actions :all, except: [:show, :edit]
  filter :version, as: :select,
                   collection: Version.includes(model: :brand),
                   member_value: :id,
                   member_label: :full_label

  controller do
    def scoped_collection
      SideView.includes version: {model: :brand}
    end
  end

  index do
    column 'Version' do |side_view|
      side_view.version.full_label
    end
    column 'Silhouette' do |side_view|
      div id: "side_view_#{side_view.id}" do
        image_tag side_view.image.thumb.url
      end
    end
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :version_id, as: :select,
                           collection: Version.approved.includes({model: :brand}, :generation).order(:updated_at).reorder,
                           member_value: :id,
                           member_label: :extended_label,
                           include_blank: false,
                           input_html: { class: 'chosen', style: 'width: 450px;' }
    end

    f.buttons
  end

  controller { with_role :admin_user }
end
