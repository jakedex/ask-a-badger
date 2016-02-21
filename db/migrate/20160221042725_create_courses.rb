class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title

      t.timestamps null: false
    end
    add_index :courses, :title, unique: true
  end
end
