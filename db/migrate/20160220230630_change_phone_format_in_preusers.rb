class ChangePhoneFormatInPreusers < ActiveRecord::Migration
   def up
    change_column :preusers, :phone, :string
  end

  def down
    change_column :preusers, :phone, :integer
  end
end
