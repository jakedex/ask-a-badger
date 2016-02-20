class TwilioController < ApplicationController
  #include Webhookable
  #after_filter :set_header
  skip_before_action :verify_authenticity_token

  # @number_to_send_to = params[:number_to_send_to]
  @twilio_phone_number = "16084674004"

  def message
    puts 'im here'
    # @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    @client = Twilio::REST::Client.new "ACe01140862912970761c0a7db87f0b6d4", "5807030bb9cebf8d8033f1031e03d96c"
    message = @client.messages.create from: '16084674004', to: '16129404706', body: 'Learning to send SMS you are.', media_url: 'http://linode.rabasa.com/yoda.gif', status_callback: request.base_url + '/twilio/status'
    render plain: message.status
  end

  def status
    # the status can be found in params['MessageStatus']
    # send back an empty response

    render_twiml Twilio::TwiML::Response.new
  end

  def messaging
    response = Twilio::TwiML::Response.new do |r|
      r.Message "Hey Monkey. Thanks for the message!"
    end
    render_twiml response
  end


end
