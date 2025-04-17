class Category < ApplicationRecord
  has_many :categorizations
  has_many :videos, through: :categorizations

  # 👇 Add this method
  def self.ransackable_associations(auth_object = nil)
    %w[categorizations videos]
  end

  # 👇 You may also need this for column filtering
  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end
end
