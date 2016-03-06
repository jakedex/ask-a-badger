class AddQuestionIdToRequest < ActiveRecord::Migration
  def change
    add_reference :requests, :question, index: true, foreign_key: true
  end
end
