class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook

    unless params["entry"].nil? || params["entry"].empty?
      sender = params["entry"][0]["messaging"][0]["sender"]["id"]

      FacebookBot.new.send_text_message(sender, "Hello")
    end
  end

end

