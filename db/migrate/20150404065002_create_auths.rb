class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.integer :user_id
      t.string :uid
      t.string :provider

      t.timestamps null: false
    end
  end
end
