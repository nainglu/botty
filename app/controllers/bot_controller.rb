class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    sender = params["entry"][0]["messaging"][0]["sender"]["id"]
    text = params["entry"][0]["messaging"][0]["message"]["text"]
    
    FacebookBot.new.send_text_message(sender, "Hello")

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end

