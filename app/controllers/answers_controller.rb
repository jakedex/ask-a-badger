class AnswersController < ApplicationController
  include ReplyHelper

  def create
    body_plain = strip_newline(params[:body_plain])
    new_ans = Answer.create(body: params[:answer][:body], body_plain: body_plain, question_id: params[:id])
    q = Question.find(params[:id])
    q.answer_id ||= new_ans.id
    q.save


  end

  def new
  end

  def strip_newline(body_plain)
    body_plain[-1..-1] == "\n" ? body_plain[0..-2] : body_plain
  end
end
