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

  #likes and comments 
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  

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





   #2fa authentication
  
   attribute :recovery_codes, :json
  
  before_create :generate_otp_secret
  before_create :generate_recovery_codes


  def otp_qrcode(provisioning_uri)
  RQRCode::QRCode.new(provisioning_uri)
  end

  def generate_otp_secret
    self.otp_secret ||= ROTP::Base32.random
  end

  def generate_recovery_codes
    self.recovery_codes = Array.new(10).map { SecureRandom.hex(6) }
  end

  def otp_provisioning_uri
    issuer = Rails.application.class.module_parent_name
    ROTP::TOTP.new(otp_secret, issuer: issuer).provisioning_uri(email)
  end

  def validate_and_consume_otp!(code)
    return false if otp_secret.nil?

    totp = ROTP::TOTP.new(otp_secret)
    if totp.verify(code, drift_behind: 15, drift_ahead: 15)
      true
    else
      # Check if it's a recovery code
      if recovery_codes.include?(code)
        recovery_codes.delete(code)
        save
        true
      else
        false
      end
    end
  end

end