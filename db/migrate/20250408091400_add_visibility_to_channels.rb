class AddVisibilityToChannels < ActiveRecord::Migration[6.1]
  def change
    add_column :channels, :visibility, :integer, default: 0, null: false
  end
end
