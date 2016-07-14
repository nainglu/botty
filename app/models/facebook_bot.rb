class FacebookBot

  def send_message(data)
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAYfjpzeZAE8BAOSWIZAkcmFOrv7DV5UT6nlJZBNdFK52ZBoyhX3sMCz7ajHfxrGuod7SB0R8YNpZABcQWedNsW7VzkPvVOYL9Ngc1ZCgtKzrQQkKDuwsTUJbZAGIvsYiu69E5Eg5qCZCIAmOGj5qkfb7sZBsrYlQU2SgVk5MbLGVAgZDZD")

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