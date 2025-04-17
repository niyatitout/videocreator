class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_many :likes, as: :likeable, dependent: :destroy

end
