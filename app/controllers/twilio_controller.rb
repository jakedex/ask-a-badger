class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    @twilio_phone_number = "16084674004"
    @initial_msg = "Simply reply in the following format to get started.\n\nFormat: course_number question\n(E.g. CS368 How do pointers work in c++?)"
    @giphy = 'https://media.giphy.com/media/ypqHf6pQ5kQEg/giphy.gif'
  end

  def send_msg
    # @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    client = Twilio::REST::Client.new "ACe01140862912970761c0a7db87f0b6d4", "5807030bb9cebf8d8033f1031e03d96c"
    # num_to = params[:num] ? params[:num] : (params[:From][1..-1]).to_i

    send_to = params[:num]
    if (@preuser = Preuser.find_by(phone:send_to)) == nil
      # create new user
      @preuser = Preuser.new(phone:send_to)
      @preuser.status = 1
    end

    message = client.messages.create(
      from: @twilio_phone_number,
      to: send_to,
      body: "Welcome to Ask A Badger. " + @initial_msg,
      media_url: @giphy
    )
    render plain: message.status
  end

  def reply
    from = params[:From][1..-1]
    body = params[:Body]
    msg_content = ""

    if (@preuser = Preuser.find_by(phone:from)) == nil
      # create new user
      @preuser = Preuser.new(phone:from)
      @preuser.status = 0
      msg_content = "Welcome to Ask A Badger. "
    end

    if (correct_format(body))   # included message format
      msg_content += "The brightest minds in Madison are plugging away at your question as you read this, your answer is on its way"
      parse_question(body)
      @preuser.status = 2
    elsif (@preuser.status == 0)   # first message
      msg_content += @initial_msg
      @preuser.status = 1
    else # not first, wrong input
      msg_content += "Hmm, something went wrong. Did you send your reply in the following format?\nFormat: course_number question"
    end

    @preuser.save

    if (@preuser.status == 0)       # new user? send gif :-)
      response = Twilio::TwiML::Response.new do |r|
        r.Message do |msg|
          msg.Body msg_content
          msg.Media @giphy
        end
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Message msg_content
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
    course_code = input[0..4]
    question = input[6..-1]

    # if (course = Course.find_by(title:course_code)) == nil
    #   # create new course
    #   course = Course.new(title:course_code)
    # end

    # add question
    # course.questions.new()

    # return "course: #{course}, q: #{question}"
  end

  def correct_format(from_message)
    from_message =~ /[a-zA-Z][a-zA-Z]\d{3}\s[a-zA-Z]+.*/ ? true : false
  end
end
