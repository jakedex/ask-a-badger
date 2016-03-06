class QuestionsController < ApplicationController

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

  def show
    @questions = Question.all
    @question = Question.find(params[:id])
    @courses = Course.all

    # Answer? If not, handle request?
    if Answer.find_by_id(@question.answer_id)
      @answer = Answer.find_by_id(@question.answer_id)
    else
      # answer question with form
      @new_answer = Answer.new

      if Request.find_by_id(@question.request_id)
        @request = Request.find_by_id(@question.request_id)
      else
        @new_request = Request.new
      end
    end
  end
end
