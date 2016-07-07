class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    if params['hub.verify_token'] == 'my_voice_is_my_password_verify_me'
      render json: params['hub.challenge']
    end

    sender = params["entry"][0]["messaging"][0]["sender"]["id"]
    res = FacebookBot.new.send_text_message(sender, "Hi thanks for messaging")

    render :nothing, status: :success
  end

end

