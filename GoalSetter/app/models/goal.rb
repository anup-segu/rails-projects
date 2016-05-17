class Goal < ActiveRecord::Base
  STATUS = ['Not Started', 'In Progress', 'Completed']
  validates :user_id, :title, presence: true
  validates :progress, inclusion: STATUS

  belongs_to :user

  has_many :comments, as: :commentable
  has_many :cheers

  def cheer_count
    cheers.count
  end
end
