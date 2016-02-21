class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :preuser, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :body
      t.string :title
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
