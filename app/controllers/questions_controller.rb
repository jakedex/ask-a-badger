class QuestionsController < ApplicationController
  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @questions = Question.all
  end

  def show
  end
end
