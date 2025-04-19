# config/initializers/turbo_streams.rb
Rails.application.config.after_initialize do
  Turbo::Streams::ActionBroadcastJob.class_eval do
    include Rails.application.routes.url_helpers
    include ActionView::Helpers
    
    def default_url_options
      Rails.application.config.action_mailer.default_url_options || {}
    end
  end
end