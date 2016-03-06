class AddRequestIdToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :request, index: true, foreign_key: true
  end
end
