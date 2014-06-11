class Part < ActiveRecord::Base
  attr_accessible :label_en, :label_fr, :manufacturer_reference, :label, :supplier_references_attributes, :brand_id

  #TODO: remove this shit and traco in favor of gettext_i18n_rails.
  translates :label

  belongs_to :category
  belongs_to :brand
  has_many :supplier_references

  accepts_nested_attributes_for :supplier_references

  validates_length_of :manufacturer_reference, :label_fr, :label_en, within: 1..50, allow_blank: true

  assignable_values_for(:brand_id) { Brand.pluck(:id) }
end
