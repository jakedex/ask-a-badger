class CreatePreusers < ActiveRecord::Migration
  def change
    create_table :preusers do |t|
      t.integer :phone

      t.timestamps null: false
    end
    add_index :preusers, :phone, unique: true
  end
end
