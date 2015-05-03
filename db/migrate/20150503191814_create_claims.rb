class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.references :op
      t.references :claimable
      t.integer :quantity, null: false, default: 1

      t.timestamps null: false
    end
  end
end
