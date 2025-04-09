class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  include Discard::Model
   after_create :create_channel
  default_scope -> { kept } # So discarded users don’t show up by default

  # Add these fields to your users table via migration
  # name:string, title:string, bio:text, avatar:string

  has_many :videos, dependent: :destroy
  has_one :channel, dependent: :destroy

  # For avatar upload (if using Active Storage)
  has_one_attached :avatar

  # Or if using CarrierWave or Paperclip
  # mount_uploader :avatar, AvatarUploader

  def first_name
    name.split.first if name.present?
  end

   def self.from_google(email:, uid: )
    find_or_create_by!(email: email, uid: uid, provider: 'google_oauth2')
  end

 

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      email
      title
      pronouns
      bio
      account_type
      created_at
      updated_at
    ]
  end
  def create_channel
    build_channel(name: "#{self.name}'s Channel").save
  end

end