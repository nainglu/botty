class FacebookBot

  def send_message(data)
    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=EAAYfjpzeZAE8BAGNAC4T6TOFGRUvsYWutmPDcU6uYa8eXHfN4cZBzhSgEmfLcSg0coWFB09QReThdA3GwaZCLi9TqxE0fZAByZCAmrcRwhlQ7asatKFkbvyAvYUVZADLp3ZBtSeRZBLQbCqIiakwNKjQ6EMQvbRAvKo3TvhRsPhcQQZDZD")

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