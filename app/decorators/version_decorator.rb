class VersionDecorator < ApplicationDecorator
  decorates :version

  def body
    version.__body
  end

  def transmission_type
    version.__transmission_type
  end

  def transmission_numbers
    version.__transmission_numbers
  end

  def full_identity_data
    version.transmission_numbers.present? && version.transmission_type.present?
  end

end