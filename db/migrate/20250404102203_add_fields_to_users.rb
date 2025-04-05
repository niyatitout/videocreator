class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :title, :string
    add_column :users, :bio, :string
    add_column :users, :avatar, :string
  end
end
