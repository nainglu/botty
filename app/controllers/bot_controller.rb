class BotController < ApplicationController

  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def webhook
    if params["hub.verify_token"] == "my_voice_is_my_voice_verify_me"
      render json: params["hub.challenge"]
    end
    unless params["entry"].nil? || params["entry"].empty?
      
      sender = params["entry"][0]["messaging"][0]["sender"]["id"]
      
      unless params["entry"][0]["messaging"][0]["message"].nil?
        text = params["entry"][0]["messaging"][0]["message"]["text"]
      else
        unless params["entry"][0]["messaging"][0]["postback"].nil?
          text = params["entry"][0]["messaging"][0]["postback"]["payload"]
        else
          text = "aaa"
        end
      end
      
      unless text == "aaa"
        if greeting.include? text
          FacebookBot.new.send_generic_message(sender, choose_topic)
        elsif text == "Website Design"
          FacebookBot.new.send_generic_message(sender, choose_web_pack)
        elsif text == "ထပ္မံေရြးခ်ယ္မည္"
          FacebookBot.new.send_generic_message(sender, choose_again)
        elsif text == "မေရြးခ်ယ္ေတာ့ပါ။"
          FacebookBot.new.send_generic_message(sender, generic)
        elsif text == "Basic"
          res = "Basic Package"
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
          FacebookBot.new.send_generic_message(sender, choose_again_quick)
        elsif text == "Standard"
          res = "Standard Package"
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
          FacebookBot.new.send_generic_message(sender, choose_again_quick)
        elsif text == "Premium"
          res = "Premium Package"
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
          FacebookBot.new.send_generic_message(sender, choose_again_quick)
        elsif text == "Website Hosting"
          res = "Hosting Plans"
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
          res = "Email & Domain Registration"
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
        else
          FacebookBot.new.send_generic_message(sender, continue)
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

    def choose_topic
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"မဂၤလာပါခင္ဗ်ာ။ ယခုလုိဆက္သြယ္ျခင္းအတြက္ ေက်းဇူးတင္ရွိပါတယ္။ မည္သည့္အေၾကာင္းအရာအတြက္ သိရွိလုိပါသလဲ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"Website Design",
                    "payload":"Website Design"
                  },
                  {
                    "type":"postback",
                    "title":"Website Hosting",
                    "payload":"Website Hosting"
                  },
                  {
                    "type":"postback",
                    "title":"Email & Domain Registration",
                    "payload":"Email & Domain Registration"
                  }
                ]
              }
            }
          }
    end

    def choose_web_pack
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"ဟုတ္ကဲ့ခင္ဗ်ာ။ အမ်ိဴးအစား (၃) မ်ဴိးရွိပါတယ္။ မည္သည့္ အမ်ိဴးအစားကုိ ေရြးခ်ယ္လုိပါသလဲခင္ဗ်ာ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"Basic",
                    "payload":"Basic"
                  },
                  {
                    "type":"postback",
                    "title":"Standard",
                    "payload":"Standard"
                  },
                  {
                    "type":"postback",
                    "title":"Premium",
                    "payload":"Premium"
                  }
                ]
              }
            }
          }
    end

    def choose_again_quick
      mes = {
          "text":"အမ်ိဴးအစား ျပန္လည္ေရြးခ်ယ္လုိပါသလား။",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"ထပ္မံေရြးခ်ယ္မည္",
              "payload":"ထပ္မံေရြးခ်ယ္မည္"
            },
            {
              "content_type":"text",
              "title":"မေရြးခ်ယ္ေတာ့ပါ။",
              "payload":"မေရြးခ်ယ္ေတာ့ပါ။"
            }
          ]
        }
    end

    def choose_again
      mes = {
            "attachment":{
              "type":"template",
              "payload":{
                "template_type":"button",
                "text":"သိရွိလုိသည့္ အမ်ဴိးအစားကုိ ျပန္လည္ေရြးခ်ယ္ပါ။",
                "buttons":[
                  {
                    "type":"postback",
                    "title":"Basic",
                    "payload":"Basic"
                  },
                  {
                    "type":"postback",
                    "title":"Standard",
                    "payload":"Standard"
                  },
                  {
                    "type":"postback",
                    "title":"Premium",
                    "payload":"Premium"
                  }
                ]
              }
            }
          }
    end

    def generic
      mes = {
              "attachment":{
                "type":"template",
                "payload":{
                  "template_type":"generic",
                  "elements":[
                    {
                      "title":"Web Factory",
                      "image_url":"http://petersapparel.parseapp.com/img/item100-thumb.png",
                      "subtitle":"We create creative websites for everyone.",
                      "buttons":[
                        {
                          "type":"postback",
                          "title":"Say Hi! Again",
                          "payload":"hi"
                        }              
                      ]
                    }
                  ]
                }
              }
            }
    end

    def continue
      mes = {
          "text":"လူႀကီးမင္း၏ ေမးျမန္းခ်က္ကုိနားမလည္ပါ။ ဆက္လက္လုပ္ေဆာင္လုိပါသလား။",
          "quick_replies":[
            {
              "content_type":"text",
              "title":"လုပ္ေဆာင္မည္။",
              "payload":"မလုပ္ေဆာင္ေတာ့ပါ။"
            },
            {
              "content_type":"text",
              "title":"မလုပ္ေဆာင္ေတာ့ပါ။",
              "payload":"မလုပ္ေဆာင္ေတာ့ပါ။"
            }
          ]
        }
    end
end

