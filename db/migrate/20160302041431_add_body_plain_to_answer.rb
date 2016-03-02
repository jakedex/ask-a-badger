class AddBodyPlainToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :body_plain, :string
  end
end
