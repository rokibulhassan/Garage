class ModelSelectOption < ActiveRecord::Base
  belongs_to :model

  validates :name, :uniqueness => { :scope => :model_id }

  # array of option values
  serialize :options, JSON

  attr_accessible :options, :name
  delegate :vehicle_type, :to => :model

  def options
    self.options = (read_attribute(:options) || [])
  end

  # returns Array of Hashes where keys are Strings and values are Arrays
  # [{ 'transmission_type' => ['first_val', 'second_val']}, {'transmission_details => [...]}]
  def self.options_for_version(version)
    [].tap do |options|
      where(:model_id => version.model_id).all.each do |option|
        options << { :options => option.options, :name => option.name, :model_id => version.model_id }
      end
    end
  end
end
