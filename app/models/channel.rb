class Channel < ApplicationRecord
  has_many :channel_members, dependent: :destroy
  has_many :users, through: :channel_members
  has_one_attached :logo
  belongs_to :user



    def self.ransackable_attributes(auth_object = nil)
    %w[
      id name description is_public user_id created_at updated_at visibility
    ]
  end

  # Optionally, allow filtering on associations:
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

end

