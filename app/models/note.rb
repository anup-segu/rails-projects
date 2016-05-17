class Note < ActiveRecord::Base
  validates :user_id, :track_id, :body, presence: true

  belongs_to :author,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :track


end
