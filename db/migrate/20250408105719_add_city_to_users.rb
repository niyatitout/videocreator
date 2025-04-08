class AddCityToUsers < ActiveRecord::Migration[7.1] # adjust version if needed
  def change
    add_column :users, :city, :string
  end
end
