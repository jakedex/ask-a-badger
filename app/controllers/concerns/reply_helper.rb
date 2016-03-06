module ReplyHelper
  include TwilioHelper

  def strip_newline(body_plain)
    body_plain[-1..-1] == "\n" ? body_plain[0..-2] : body_plain
  end

  def handle_oddcase(user)
    # already awaiting response
    if(user.status == 2)
      return "Sorry, we can only process one question/per at this moment. Please wait for a response to your previous question."
    end

    # 2 or more invalid
    if(user.attempts >= 2)
      user.attempts = 0
      user.save
      return "Having trouble? Try checking out our FAQ at ask-a-badger.com/faq"
    end
  end

  def handle_reply(user, body, msg_content)
    reply_msg = msg_content

    # already awaiting or too many errors
    if(user.status == 2 || user.attempts >= 2)
      return handle_oddcase(user)
    end

    # handle request response
    if(user.status == 3)
      return handle_request_response(user, body)
    end

    # handle help response
    if(body.downcase == 'helpme')
      return "This is our unimplemented help message ;-)"
    end

    if (correct_format(body))
      reply_msg += "The brightest minds in Madison are plugging away at your question as you read this. Hold tight, your answer is on its way."
      parse_question(body, user)
      user.status = 2
    elsif (user.status == 0)   # first message
      reply_msg += "Simply reply in the following format to get started.\n\nFormat: COURSE QUESTION\n(E.g. CS368 How do pointers work in c++?)"
    else # not first, wrong input
      reply_msg += "Hmm, something went wrong. Did you send your reply in the following format?\nCOURSE QUESTION"
      user.attempts = user.attempts + 1
    end

    user.save
    return reply_msg
  end

  # TODO free msg count...
  def handle_answer(preuser, answer)
    to = preuser.phone
    from = "16084674004"
    body = answer.as_text ? "Answer: " + answer.body_plain : "Your question has been answered at http://www.askabadger.com/questions/#{answer.question_id}"

    send_msg(to, from, body, nil)
    preuser.status = 4
    preuser.save

    body = "Thanks for using Ask a Badger! 🌟"
    send_msg(to, from, body, nil)
  end

  def handle_request(preuser, request)
    to = preuser.phone
    from = "16084674004"
    body = "More information is needed from you: " + request.body_plain

    send_msg(to, from, body, nil)
    preuser.status = 3
    preuser.save
  end

  def handle_request_response(preuser, response)
    # TODO needsss work ;) this only works when we have 1 active q/preuser
    request = Request.find(preuser.questions.last.request_id)
    request.response = response
    request.save

    preuser.status = 2
    preuser.save
  end
end
