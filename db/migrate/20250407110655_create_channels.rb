class CreateChannels < ActiveRecord::Migration[8.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description
      t.string :logo_url
      t.boolean :is_public
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
