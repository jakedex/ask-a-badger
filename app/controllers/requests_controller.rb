class RequestsController < ApplicationController
  include ReplyHelper

  def create
    # strip trailing newline
    body_plain = strip_newline(params[:body_plain])

    # create new answer, associate w question TODO schema work!
    new_req = Request.create(body: params[:request][:body], body_plain: body_plain, question_id: params[:id])
    q = Question.find(params[:id])
    q.request_id = new_req.id
    if q.save
      flash[:success] = "Your request has been submitted successfully."
      # send out request to asker
      preuser = Preuser.find(q.preuser_id)
      handle_request(preuser, new_req)
    end
  end
end
