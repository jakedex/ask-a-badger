module TwilioHelper

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
