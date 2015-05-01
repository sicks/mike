class CreateCorps < ActiveRecord::Migration
  def change
    create_table :corps do |t|
      t.integer :ccp_id, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
