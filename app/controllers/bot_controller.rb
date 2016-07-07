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
          mes = {
                  "attachment":{
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
        elsif respond == "bubble"
          mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"What do you want to do next?",
                "buttons":[
                  {
                    "type":"web_url",
                    "url":"https://petersapparel.parseapp.com",
                    "title":"Show Website"
                  },
                  {
                    "type":"postback",
                    "title":"Start Chatting",
                    "payload":"USER_DEFINED_PAYLOAD"
                  }
                ]
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
        elsif respond == "video"
          mes = {
            "attachment":{
              "type":"video",
              "payload":{
                "url":"https://petersapparel.com/bin/clip.mp4"
              }
            }
          }
          FacebookBot.new.send_generic_message(sender, mes)
        elsif respond == "quick"
          mes = {
                  "text":"Pick a color:",
                  "quick_replies":[
                    {
                      "content_type":"text",
                      "title":"Red",
                      "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
                    },
                    {
                      "content_type":"text",
                      "title":"Green",
                      "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
                    }
                  ]
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

