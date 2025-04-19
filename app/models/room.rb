class Room < ApplicationRecord
	  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
after_create_commit -> { broadcast_append_to "room_#{self.id}_messages", target: "messages" }
end
