
class TwilioController < ApplicationController
  include TwilioHelper
  include ReplyHelper
  skip_before_action :verify_authenticity_token

  def initialize
    @twilio_phone_number = "16084674004"
    @initial_msg = "Simply reply in the following format to get started.\n\nFormat: COURSE QUESTION\n(E.g. CS368 How do pointers work in c++?)"
    @giphy = 'https://media.giphy.com/media/ypqHf6pQ5kQEg/giphy.gif'
  end

  # sends text to number entered on the frontend
  def send_frontend
    to = remove_country_code params[:num]
    body = "Welcome to Ask A Badger. " + @initial_msg

    if (@preuser = Preuser.find_by(phone:to)) == nil
      # create new user
      @preuser = Preuser.new(phone:to)
      @preuser.status = 1
      @preuser.save
    end

    message = send_msg(to, @twilio_phone_number, body, nil)

    render plain: message.status
  end

  # -- Status codes --
  # - 0 : new user, no previous messages
  # - 1 : has been sent gif msg
  # - 2 : has asked valid question, awaiting response
  # - 3 : question answered, standby mode
  def reply
    from = remove_country_code params[:From]
    body = params[:Body]
    msg_content = ""

    # create new user if needed
    if (@preuser = Preuser.find_by(phone:from)) == nil
      @preuser = Preuser.new(phone:from)
      msg_content = "Welcome to Ask A Badger. "
    end

    msg_content = handle_reply(@preuser, body, msg_content)

    # new user? send gif :-)
    if (@preuser.status == 0)
      response = Twilio::TwiML::Response.new do |r|
        r.Message do |msg|
          msg.Body msg_content
          # msg.Media @giphy
        end
      end

      @preuser.status = 1
    else
      # existing, no gif ;(
      response = Twilio::TwiML::Response.new do |r|
        r.Message msg_content
      end
    end

    @preuser.save
    render text: response.text
  end

  # def status
  #   # the status can be found in params['MessageStatus']
  #   # send back an empty response

  #   render text: Twilio::TwiML::Response.new.text
  # end
end
