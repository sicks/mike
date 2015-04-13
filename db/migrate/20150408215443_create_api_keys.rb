class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.integer :key_id, null: false
      t.string :vcode, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
