class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    if params["hub.verify_token"] == "my_voice_is_my_voice_verify_me"
      render json: params["hub.challenge"]
    end
    unless params["entry"].nil? || params["entry"].empty?
      unless params["entry"][0]["messaging"][0]["message"].nil?
        sender = params["entry"][0]["messaging"][0]["sender"]["id"]
        text = params["entry"][0]["messaging"][0]["message"]["text"]

        if greeting.include? text
          res = "Hello! Nice to meet you. 
                  What language do you want to use for further conversation."
          choose_lang_quick.merge!(text: res)         
          FacebookBot.new.send_generic_message(sender, choose_lang_quick)

          if text == "Myanmar" || text == "English"
            if text == "Myanmar"
              res = "ဟုတ္ကဲ့ ။ လူႀကီးမင္းအေနနဲ႔ ဘယ္အေၾကာင္းအရာျဖင့္ ပတ္သက္ပီး သိလုိပါသလဲ။"
              topic_bubble[:attachment][:payload].merge!(text: res)
            else
              res = "Excellent! please specify your question."
              topic_bubble[:attachment][:payload].merge!(text: res)
            end
            FacebookBot.new.send_generic_message(sender, topic_bubble)
          elsif text == "Website Design"
            res = "Okay! one more thing, what do you want to know?"
            FacebookBot.new.send_text_message(sender, res)
            FacebookBot.new.send_generic_message(sender, web_pack_quick_reply)
          elsif text == "Website Hosting"
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
            FacebookBot.new.send_generic_message(sender, mes)
          elsif text == "Email & Domain Registration"

            FacebookBot.new.send_generic_message(sender, bubble_template)
          end

      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private
    def greeting
      ["မဂၤလာပါ", "ဟုိင္း", "Hi", "hi", "Hello", "hello", 
        "HELLO", "HI"]
    end


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

    def topic_bubble
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"What do you want to do next?",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"Website Design",
                    "payload":"defined_payload"
                  },
                  {
                    "type":"postback",
                    "title":"Website Hosting",
                    "payload":"defined_payload"
                  },
                  {
                    "type":"postback",
                    "title":"Email & Domain Registration",
                    "payload":"defined_payload"
                  }
                ]
              }
            }
          }
    end

    def topic_quick_reply
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

    def choose_lang_quick
      mes = {
            "text":"Choose a topic.",
            "quick_replies":[
              {
                "content_type":"text",
                "title":"Myanmar",
                "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
              },
              {
                "content_type":"text",
                "title":"English",
                "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
              }
            ]
          }
    end

end

