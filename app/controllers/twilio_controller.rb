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
    message = @client.messages.create from: '16084674004', to: '16129404706', body: 'Learning to send SMS you are.', media_url: 'http://linode.rabasa.com/yoda.gif', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def reply
    if (Preuser.exists?(phone:params[:from]))
      message = "Hey, #{params[:from]}"
    else
      user = Preuser.new(phone:params[:from])
      user.save
      message = "Created a new user"
    end

    # session["counter"] ||= 0
    # sms_count = session["counter"]
    # if sms_count == 0
    #   message = "Hello, thanks for the new message."
    # else
    #   message = "Hello, thanks for message number #{sms_count + 1}"
    # end
    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    render text: response.text
  end

  def status
    # the status can be found in params['MessageStatus']
    # send back an empty response

    render text: Twilio::TwiML::Response.new.text
  end

end
