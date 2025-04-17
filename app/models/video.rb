class Video < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true  # optional: true allows nil
  has_many_attached :files
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # Remove the many-to-many setup:
  # has_many :categorizations, dependent: :destroy
  # has_many :categories, through: :categorizations
end