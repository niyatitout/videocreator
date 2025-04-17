# db/migrate/[timestamp]_create_likes.rb
class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false  # This creates likeable_id + likeable_type
      t.boolean :liked
      t.timestamps
    end
  end
end