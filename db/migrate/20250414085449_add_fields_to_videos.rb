class AddFieldsToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :audience, :string
    add_column :videos, :age_restriction, :integer
    add_column :videos, :scheduled_at, :datetime
  end
end
