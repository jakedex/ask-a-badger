class AnswersController < ApplicationController
  def create
    new_ans = Answer.create(body: params[:answer][:body], question_id: params[:id])
    q = Question.find(params[:id])
    q.answer_id ||= new_ans.id
    q.save
  end

  def new
  end
end
