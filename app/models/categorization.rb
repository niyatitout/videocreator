class Categorization < ApplicationRecord
  belongs_to :video
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "id_value", "updated_at", "video_id"]
  end

end
