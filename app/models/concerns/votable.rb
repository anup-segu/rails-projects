module Votable
  extend ActiveSupport::Concern

  included do
    has_many :uservotes, as: :votable,
      class_name: "Uservote",
      dependent: :destroy
  end

  def votes
    self.uservotes.sum(:value)
  end
end
