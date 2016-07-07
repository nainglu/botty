class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    
    FacebookBot.new.send_text_message(sender, "Hello")

    render :nothing, status: 200
  end

end

