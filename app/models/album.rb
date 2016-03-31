class Album < ActiveRecord::Base
  ALBUM_TYPE = ['live', 'studio']

  validates :name, :band_id, :ttype, presence: true
  validates :name, uniqueness: true
  validates :ttype, inclusion: { in: ALBUM_TYPE }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
