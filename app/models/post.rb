class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  # validate :ensure_sub

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User

  has_many :post_subs

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments

  def has_no_sub?
    self.post_subs.empty?
  end

  def ensure_sub
    if has_no_sub?
      errors[:no_sub] << "No sub selected"
    end
  end
end
