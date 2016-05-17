class Cheer < ActiveRecord::Base
  validates :goal_id, :user_id, presence: true
  validate :cheer_limit

  belongs_to :user
  belongs_to :goal


  CHEER_LIMIT = 10

  def cheer_limit
    unless Cheer.where(user_id: self.user_id).count < CHEER_LIMIT
      errors[:user_id] << "Don't have enough cheers"
    end
  end

end
