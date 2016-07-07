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

        if respond == "generic"
          mes = {"attachment":{
                    "type":"template",
                    "payload":{
                      "template_type":"generic",
                      "elements":[
                        {
                          "title":"Welcome to Peter\'s Hats",
                          "image_url":"http://petersapparel.parseapp.com/img/item100-thumb.png",
                          "subtitle":"We\'ve got the right hat for everyone.",
                          "buttons":[
                            {
                              "type":"web_url",
                              "url":"https://petersapparel.parseapp.com/view_item?item_id=100",
                              "title":"View Website"
                            },
                            {
                              "type":"postback",
                              "title":"Start Chatting",
                              "payload":"USER_DEFINED_PAYLOAD"
                            }              
                          ]
                        }
                      ]
                    }
                  }
                }
          FacebookBot.new.send_generic_message(sender, mes)
        else
          FacebookBot.new.send_text_message(sender, respond)
        end
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end

