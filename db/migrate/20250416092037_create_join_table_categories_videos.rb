class CreateJoinTableCategoriesVideos < ActiveRecord::Migration[8.0]
  def change
    create_join_table :categories, :videos do |t|
      # t.index [:category_id, :video_id]
      # t.index [:video_id, :category_id]
    end
  end
end
