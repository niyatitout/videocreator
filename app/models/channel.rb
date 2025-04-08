class Channel < ApplicationRecord
  has_many :channel_members, dependent: :destroy
  has_many :users, through: :channel_members
  has_one_attached :logo
  belongs_to :user

end