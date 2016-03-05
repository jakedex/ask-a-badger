module TwilioHelper

    def send_msg(to, from, msg, media_url)
    # @client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    client = Twilio::REST::Client.new "ACe01140862912970761c0a7db87f0b6d4", "5807030bb9cebf8d8033f1031e03d96c"

    # handle no media_url, return message
    message = media_url ? client.messages.create(
      from: from,
      to: to,
      body: msg,
      media_url: media_url
    ) :
    client.messages.create(
      from: from,
      to: to,
      body: msg
    )
  end

  # case: no num code
  # case: num code (1)
  # case: num code and pre (+1)
  # case: just pre? (+)
  def remove_country_code num
    # strip +
    if (num[0] == '+')
      num = num[1..-1]
    end

    # strip 1
    num.length > 10 ? num[1..-1] : num
  end

  def parse_question(input, user)
    course_code = input[0..4].upcase
    question = input[6..-1]

    if (course = Course.find_by(title:course_code)) == nil
      # create new course
      course = Course.new(title:course_code)
    end

    # add question
    question = course.questions.new(preuser_id: user.id, :body => "Test body", :title => question)
    user.questions << question

    course.save
  end

  def correct_format(from_message)
    from_message =~ /[a-zA-Z][a-zA-Z]\d{3}\s[a-zA-Z]+.*/ ? true : false
  end
end
