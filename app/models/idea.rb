class Idea < ApplicationRecord
  belongs_to :user ,optional: true
  has_many :reviews

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  def like_for(user)
    # likes.where(user_id: user.id).first
    likes.find_by_user_id(user)
  end

end
