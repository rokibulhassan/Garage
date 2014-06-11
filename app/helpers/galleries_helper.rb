module GalleriesHelper
  def button_to_edit_gallery(gallery)
    link_to '#edit-gallery', class: 'edit-gallery btn', data: { toggle: 'modal' } do
      content_tag(:i, '', class: 'icon-pencil') +
      ' Change the title'
    end
  end

  def button_to_delete_gallery(gallery)
    link_to '#delete-gallery', class: 'delete-gallery btn btn-danger', data: { toggle: 'modal' } do
      content_tag(:i, '', class: 'icon-trash icon-white') +
      ' Delete the gallery'
    end
  end

  def button_to_add_pictures(gallery)
    link_to '#add-picture', class: 'btn btn-primary', data: { toggle: 'modal' } do
      content_tag(:i, '', class: 'icon-camera icon-white') +
      ' Add pictures'
    end
  end
end
