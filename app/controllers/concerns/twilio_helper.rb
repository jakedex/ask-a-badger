module TwilioHelper

  def remove_country_code num
    num.length > 10 ? num[1..-1] : num
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
