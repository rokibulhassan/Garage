class VehicleAdminDecorator < ApplicationDecorator
  decorates :vehicle

  STATUSES_MAPPING = {Version::UNAPPROVED => :error, Version::PENDING => :warning, Version::APPROVED => :ok}

  def silhouette
    if vehicle.side_view
      h.content_tag :div, id: "side_view_#{vehicle.side_view.id}" do
        h.image_tag vehicle.side_view.image.thumb.url
      end
    end
  end

  def label
    link   = h.link_to title, h.admin_vehicle_path(vehicle)
    status = unless vehicle.version.approved?
      version = VersionDecorator.new vehicle.version
      klass, text = version.full_identity_data ? ["full-data", "identified"] : ["status_tag #{STATUSES_MAPPING[vehicle.version.status.to_sym]}", vehicle.version.status]

      h.content_tag :div, h.content_tag(:span, text, class: klass)
    else
      ""
    end

    link + status
  end

  def status
    h.content_tag :span, vehicle.version.status, class: "status_tag #{STATUSES_MAPPING[vehicle.version.status.to_sym]}"
  end

  def mods
    vehicle.modifications.length
  end

  def user
    h.link_to vehicle.user.username, h.admin_user_path(vehicle.user)
  end

  def locale
    "#{vehicle.user.locale}-#{vehicle.user.country_code}"
  end

  def generation_label
    vehicle.version.generation.label
  end

  def model_year
    vehicle.version.production_year
  end

  def version_name
    vehicle.version.name
  end

  def title
    "#{version.model.brand.name} #{version.model.name}"
  end
end