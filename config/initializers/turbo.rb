# config/initializers/turbo.rb
Rails.application.reloader.to_prepare do
  Turbo::Streams::BroadcastJob.queue_adapter = :inline
end 