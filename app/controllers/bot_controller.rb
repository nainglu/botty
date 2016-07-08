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

        if text == "Hi" || text == "hi"
          res = "Hi! I'm Botty. what would you like to ask me about?"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, topic_quick_reply)
        elsif text == "Website Package"
          res = "Okay! one more thing, what do you want to know?"
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, mes)
        elsif text == "Package Comparison"
          res = "Here you go!"
          mes = {
            "attachment":{
              "type":"image",
              "payload":{
                "url":"http://www.gstatic.com/webp/gallery/2.jpg"
              }
            }
          }
          FacebookBot.new.send_text_message(sender, res)
          FacebookBot.new.send_generic_message(sender, web_pack_quick_reply)
        elsif text == "bubble"

          FacebookBot.new.send_generic_message(sender, bubble_template)
        end

      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private
    def generic_template
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
    end

    def bubble_template
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
                    "payload":"say hi"
                  }
                ]
              }
            }
          }
    end

    def topic_quick_reply
      mes = {
              "text":"Choose a topic.",
              "quick_replies":[
                {
                  "content_type":"text",
                  "title":"Website Package",
                  "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
                },
                {
                  "content_type":"text",
                  "title":"Random Chat",
                  "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
                }
              ]
            }
    end

    def web_pack_quick_reply
      mes = {
              "text":"Choose a topic.",
              "quick_replies":[
                {
                  "content_type":"text",
                  "title":"Package Comparison",
                  "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
                },
                {
                  "content_type":"text",
                  "title":"Support Options",
                  "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
                }
              ]
            }
    end

end

