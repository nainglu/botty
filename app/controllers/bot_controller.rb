class BotController < ApplicationController

  def webhook
    if params['hub.verify_token'] == 'my_voice_is_my_password_verify_me'
      render json: params['hub.challenge']
    end

    unless params["entry"].nil? || params["entry"].empty?
      sender = params["entry"][0]["messaging"][0]["sender"]["id"]
      res = FacebookBot.new.send_text_message(sender, "Hi thanks for messaging")
    end
  end

end