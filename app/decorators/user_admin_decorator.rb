class UserAdminDecorator < ApplicationDecorator
  decorates :user

  def avatar
    h.link_to h.image_tag(user.avatar_url, size: "50x50", alt: user.full_name, title: user.full_name), h.admin_user_path(user)
  end

  def name
    user.full_name
  end

  def vehicles_quantity
    h.content_tag :div, class: 'quantities' do
      link_to_approved = h.link_to user.vehicles.approved.length,
                                 h.admin_vehicles_path('q' => { 'user_id_eq' => user.id, 'version_status_eq' => Version::APPROVED})
      link_to_unapproved = h.link_to user.vehicles.not_approved.length,
                                   h.admin_vehicles_path('q' => { 'user_id_eq' => user.id, 'version_status_eq' => Version::UNAPPROVED})

      "#{link_to_approved} <b>(#{link_to_unapproved})</b>".html_safe
    end

  end

  def country_with_locale
    "#{country} (#{user.locale})"
  end

  def registered_at
    user.created_at
  end

  def country
    Country[user.country_code].name
  end
end