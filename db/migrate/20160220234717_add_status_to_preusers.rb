class AddStatusToPreusers < ActiveRecord::Migration
  def change
    add_column :preusers, :status, :integer
  end
end
