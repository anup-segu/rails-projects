class Post < ActiveRecord::Base
  include Votable
  
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

  def all_comments
    @all_comments ||= self.comments.includes(:author)
  end

  def order_comments_by_parent_id
    ordered_comments = Hash.new { |hash,key| hash[key] = [] }
    all_comments.each do |comment|
      ordered_comments[comment.parent_comment_id] << comment
    end
    ordered_comments
  end

  def all_comments_by_parent_id
    @all_comments_by_parent_id ||= order_comments_by_parent_id
  end

  private
  def has_no_sub?
    self.post_subs.empty?
  end

  def ensure_sub
    if has_no_sub?
      errors[:no_sub] << "No sub selected"
    end
  end
end
