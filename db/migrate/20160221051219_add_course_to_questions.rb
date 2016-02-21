class AddCourseToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :course, index: true, foreign_key: true
  end
end
