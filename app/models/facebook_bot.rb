class FacebookBot

  def send_message(data)
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAYfjpzeZAE8BADKmFCZCWv2QTZCZBOFVqe2N7noH0hI0fnLIomf02ZBqPnOj6OgkSHVHUBZA0HQ4ZAcBXYVArF6ZAiBDfFTce34JOf95GzRecza10gzFfbuETmdK3QpzHXQPr6PyHl2ZAPZCJNrdmzTQgKTkobwPF8ZAF5oMnUd005wgZDZD")

    http = Net::HTTP.new(url.host, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE #only for development.
    begin
      request = Net::HTTP::Post.new(url.request_uri)
      request["Content-Type"] = "application/json"
      request.body = data.to_json
      response = http.request(request)
      body = JSON(response.body)
      return { ret: body["error"].nil?, body: body }
    rescue => e
      raise e
    end
  end

  def send_text_message(sender, text)
    data = {
      recipient: { id: sender },
      message: { text: text }
    }
    send_message(data)
  end

  def send_generic_message(sender, mes)
    data = {
      recipient: { id: sender },
      message: mes
    }
    send_message(data)
  end

  
end