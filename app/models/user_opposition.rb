class UserOpposition < ActiveRecord::Base
  attr_accessible :opposer_id
  belongs_to :user
  belongs_to :opposer, class_name: 'User'

  assignable_values_for :opposer do
    User.where { id.not_eq my{self.user_id} }
  end
end
