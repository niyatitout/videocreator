class AddViewsToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :views, :integer
  end
end
