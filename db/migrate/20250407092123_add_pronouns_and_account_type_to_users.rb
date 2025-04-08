class AddPronounsAndAccountTypeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :pronouns, :string
    add_column :users, :account_type, :string
  end
end
