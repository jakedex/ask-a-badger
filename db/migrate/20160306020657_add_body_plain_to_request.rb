class AddBodyPlainToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :body_plain, :string
  end
end
