class CoursesController < ApplicationController
  include CoursesHelper

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find_by(title: params[:course])
    @new_answer = Answer.new
  end
end
