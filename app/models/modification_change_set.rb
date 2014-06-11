class ModificationChangeSet < ActiveRecord::Base
  belongs_to :modification
  belongs_to :change_set
end
