class AddCategoryToVideos < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :category, null: true, foreign_key: true
  end
end
