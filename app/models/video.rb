class Video < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :views_count, numericality: { greater_than_or_equal_to: 0 }
  validates :shares_count, numericality: { greater_than_or_equal_to: 0 }

  # If you want to add a default scope for ordering
  default_scope { order(created_at: :desc) }
end