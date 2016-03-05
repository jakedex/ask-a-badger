class AnswersController < ApplicationController
  include ReplyHelper

  def create
    # strip trailing newline
    body_plain = strip_newline(params[:body_plain])

    # create new answer, associate w question TODO schema work!
    as_text = params[:reply] == "text"
    new_ans = Answer.create(body: params[:answer][:body], body_plain: body_plain, as_text: as_text, question_id: params[:id])
    q = Question.find(params[:id])
    q.answer_id ||= new_ans.id
    if q.save
      flash[:success] = "Your answer has been submitted successfully."
      # send out response to asker
      preuser = Preuser.find(q.preuser_id)
      handle_answer(preuser, new_ans)
    end


  end

  def new
  end

  def strip_newline(body_plain)
    body_plain[-1..-1] == "\n" ? body_plain[0..-2] : body_plain
  end
end
