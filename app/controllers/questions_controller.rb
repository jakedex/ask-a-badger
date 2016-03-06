class QuestionsController < ApplicationController
  include ReplyHelper

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @questions = Question.all
    @courses = Course.all
    # answer question with form
    @new_answer = Answer.new
  end

  def create_request
    # strip trailing newline
    body_plain = strip_newline(params[:body_plain])

    # create new answer, associate w question TODO schema work!
    as_text = params[:reply] == "text"
    new_req = Request.create(body: params[:request][:body], body_plain: body_plain, as_text: as_text, question_id: params[:id])
    q = Question.find(params[:id])
    q.answer_id ||= new_ans.id
    if q.save
      flash[:success] = "Your answer has been submitted successfully."
      # send out response to asker
      preuser = Preuser.find(q.preuser_id)
      handle_answer(preuser, new_ans)
    end

  end

  def show
    @questions = Question.all
    @question = Question.find(params[:id])
    @courses = Course.all

    if Answer.find_by_id(@question.answer_id)
      @answer = Answer.find_by_id(@question.answer_id)
    else
      # answer question with form
      @new_answer = Answer.new
      @new_request = Request.new
    end
  end
end
