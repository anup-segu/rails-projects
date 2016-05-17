class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :User

  # has_many :posts
  has_many :post_subs
  has_many :posts,
    through: :post_subs,
    source: :post


  def posts_by_votes
    self.posts.sort { |p1, p2| p2.votes <=> p1.votes }
  end

end
