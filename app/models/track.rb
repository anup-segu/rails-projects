class Track < ActiveRecord::Base
  TRACK_TYPES = ['bonus','regular']
  validates :name, :album_id, :ttype, presence: true
  validates :ttype, inclusion: { in: TRACK_TYPES }

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band
end
