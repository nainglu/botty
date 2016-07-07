class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    if params["hub.verify_token"] == "my_voice_is_my_password_verify_me"
      render json: params["hub.challenge"]
    end
    unless params["entry"].nil? || params["entry"].empty?
      unless params["entry"][0]["messaging"][0]["message"].nil?
        sender = params["entry"][0]["messaging"][0]["sender"]["id"]
        text = params["entry"][0]["messaging"][0]["message"]["text"]

        respond = I18n.t(text)

        FacebookBot.new.send_text_message(sender, respond)
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end

