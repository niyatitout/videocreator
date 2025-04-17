class AddVideoIdToLikes < ActiveRecord::Migration[8.0]
  def change
    add_column :likes, :video_id, :integer
  end
end
