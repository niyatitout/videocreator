# app/helpers/messages_helper.rb
module MessagesHelper
  def render_message_content(content)
    sanitize(content, tags: %w(img br p), attributes: %w(src style class))
  end
end