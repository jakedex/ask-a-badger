class TwilioController < ApplicationController
  #include Webhookable
  #after_filter :set_header
  skip_before_action :verify_authenticity_token
  # enable :sessions

  # @number_to_send_to = params[:number_to_send_to]
  @twilio_phone_number = "16084674004"

  def message
    # @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    @client = Twilio::REST::Client.new "ACe01140862912970761c0a7db87f0b6d4", "5807030bb9cebf8d8033f1031e03d96c"
    message = @client.messages.create from: '16084674004', to: '16129404706', body: 'Learning to send SMS you are.', media_url: 'https://media.giphy.com/media/ypqHf6pQ5kQEg/giphy.gif', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def reply
    from = params[:From][1..-1]
    if (@preuser = Preuser.find_by(phone:from) != nil) #user exists
      body = params[:Body] #remove later
      message = parse_question(body)
    else    # create new user
      @preuser = Preuser.new(phone:from)
      @preuser.status = 0
      message = "Welcome to Ask A Badger. "

      body = params[:Body]
      if (correct_format(body))   # included message format
        message += "The brightest minds in Madison are plugging away at your question as you read this, your answer is on its way"
        parse_question(body)
        @preuser.status = 1
      else        # anything else
        message += "Simply reply in the following format to get started.\n\nFormat: college class_number question\n(E.g. CS 368 How pointers work in c++?) #{@preuser.phone}"
      end

      @preuser.save
    end

    if (@preuser.status == 0)       # new user? send gif :-)
      response = Twilio::TwiML::Response.new do |r|
        r.Message do |msg|
          msg.Body message
          msg.Media 'https://media.giphy.com/media/ypqHf6pQ5kQEg/giphy.gif'
        end
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Message message
      end
    end

    render text: response.text
  end

  def status
    # the status can be found in params['MessageStatus']
    # send back an empty response

    render text: Twilio::TwiML::Response.new.text
  end

  def parse_question(input)
    college_code = input[0..1]
    course = input[3..5]
    question = input[7..-1]

    # @preuser.questions
    return "code #{college_code}, course: #{course} ,question: #{question}"
  end

  def correct_format(from_message)
    from_message =~ /[a-zA-Z][a-zA-Z]\s\d{3}\s[a-zA-Z]+.*/ ? true : false
  end

  def convo

  end

end
