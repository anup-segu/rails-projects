class Album < ActiveRecord::Base
  validates :name, :band_id, :ttype, presence: true
  validates :name, uniqueness: true
  validates :ttype, inclusion: { in: ['live', 'studio'] }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
