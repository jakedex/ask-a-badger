module ReplyHelper
  include TwilioHelper

  def initialize
    @initial_msg = "Simply reply in the following format to get started.\n\nFormat: course_number question\n(E.g. CS368 How do pointers work in c++?)"
    @valid_response = "The brightest minds in Madison are plugging away at your question as you read this. Hold tight, your answer is on its way."
  end

  # TODO remember to reset attempts/status to zero after answering
  def handle_oddcase(user)
    # already awaiting response
    if(user.status == 2)
      return "Sorry, we can only process one question/per at this moment. Please wait for a response to your previous question."
    end

    # 2 or more invalid
    if(user.attempts >= 2)
      return "Having trouble? Try checking out our FAQ at ask-a-badger.com/faq"
    end
  end

  def handle_reply(user, body, msg_content)
    reply_msg = msg_content

    # already awaiting or too many errors
    if(user.status == 2 || user.attempts >= 2)
      return handle_oddcase(user)
    end

    if (correct_format(body))
      reply_msg += @valid_response
      parse_question(body)
      user.status = 2
    else


    user.save
    return reply_msg
  end
      if (correct_format(body))
      msg_content +=
      parse_question(body)
      @preuser.status = 2
    elsif (@preuser.status == 0)   # first message
      msg_content += @initial_msg
    else # not first, wrong input
      msg_content += "Hmm, something went wrong. Did you send your reply in the following format?\nFormat: course_number question"
    end


end
