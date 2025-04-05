class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add these fields to your users table via migration
  # name:string, title:string, bio:text, avatar:string

  has_many :videos, dependent: :destroy

  # For avatar upload (if using Active Storage)
  has_one_attached :avatar

  # Or if using CarrierWave or Paperclip
  # mount_uploader :avatar, AvatarUploader

  def first_name
    name.split.first if name.present?
  end
end