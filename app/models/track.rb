class Track < ActiveRecord::Base
  validates :name, :album_id, :ttype, presence: true
  validates :ttype, inclusion: { in: ['bonus','regular'] }

  belongs_to :album
end
