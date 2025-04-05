class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :thumbnail_url
      t.integer :views_count
      t.integer :shares_count

      t.timestamps
    end
  end
end
