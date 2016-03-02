class AddAsTextToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :as_text, :boolean
  end
end
