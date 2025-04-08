# app/models/channel_member.rb
class ChannelMember < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  validates :role, inclusion: { in: %w[viewer contributor admin] }
end