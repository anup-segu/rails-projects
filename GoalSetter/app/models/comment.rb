class Comment < ActiveRecord::Base
  validates :body, :user_id, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :author, foreign_key: :user_id, class_name: :User
end
