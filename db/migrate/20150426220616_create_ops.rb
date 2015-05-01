class CreateOps < ActiveRecord::Migration
  def change
    create_table :ops do |t|
      t.string :name, null: false, default: ""
      t.references :corp
      t.references :user
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
  end
end
