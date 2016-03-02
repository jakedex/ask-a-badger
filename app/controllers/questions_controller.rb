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
  end

  def show
    @questions = Question.all
    @question = Question.find(params[:id])
    @courses = Course.all

    # answer question
    @answer = Answer.new
  end
end
