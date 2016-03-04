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

    @answer = Answer.find_by_id(@question.answer_id)
    # answer question with form
    @new_answer = Answer.new
  end
end
