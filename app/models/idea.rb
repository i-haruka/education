class Idea < ApplicationRecord
  has_one_attached :image
  has_many :idea_comments, dependent: :destroy
  belongs_to :user

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @idea = Idea.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @idea = Idea.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @idea = Idea.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @idea = Idea.where("title LIKE?","%#{word}%")
    else
      @idea = Idea.all
    end
  end
end
