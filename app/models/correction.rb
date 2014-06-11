class Correction < ActiveRecord::Base
  belongs_to :version_property
  belongs_to :corrector, class_name: 'User'

  after_create :accept_if_not_unique_correction_for_property

  def self.by_user(user)
    where(:corrector_id => user.id)
  end

  def self.with_value_and_property(value, version_property)
    where(:version_property_id => version_property.id, :value => value)
  end

  def accept!
    version_property.value = value
    version_property.user_id = corrector_id
    version_property.save! && destroy
  end

  def reject!
    destroy
  end

  protected

  def accept_if_not_unique_correction_for_property
    corrections = Correction.with_value_and_property(value, version_property).all
    if corrections.size >= 2
      corrections.delete_if { |cor| cor == self && cor.accept! }
      corrections.each(&:destroy)
    end
  end
end
