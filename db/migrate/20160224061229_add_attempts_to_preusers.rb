class AddAttemptsToPreusers < ActiveRecord::Migration
  def change
    add_column :preusers, :attempts, :integer
  end
end
