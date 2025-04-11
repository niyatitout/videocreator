class AddTwoFactorFieldsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :otp_secret, :string
    add_column :users, :otp_required_for_login, :boolean
    add_column :users, :recovery_codes, :text
  end
end
