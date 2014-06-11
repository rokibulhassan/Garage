# join model
class PrewrittenCommentsVersionUser < ActiveRecord::Base
  self.table_name = 'prewritten_comments_version_user'

  belongs_to :user
  belongs_to :version
  belongs_to :prewritten_comment, class_name: 'PrewrittenVersionComment'

  validates :user_id, presence: true
  validates :version_id, presence: true, uniqueness: { scope: :user_id }
  validates :prewritten_comment_id, presence: true
end
