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
    @question = Question.find(params[:id])
    @answer = @question.answer_id ? @question.answer_id : nil
    @courses = Course.all
  end
end
