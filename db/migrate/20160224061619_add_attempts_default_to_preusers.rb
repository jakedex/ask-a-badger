class AddAttemptsDefaultToPreusers < ActiveRecord::Migration
  def change
    change_column :preusers, :status, :integer, :default => 0
    change_column :preusers, :attempts, :integer, :default => 0
  end
end
