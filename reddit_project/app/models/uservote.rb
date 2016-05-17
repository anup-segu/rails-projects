class Uservote < ActiveRecord::Base
  validates :user, :value, presence: true
  validates :value, inclusion: { in: [-1, 1] }

  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type] }

  belongs_to :votable, polymorphic: true
  belongs_to :user, inverse_of: :uservotes
end
