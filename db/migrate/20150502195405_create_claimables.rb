class CreateClaimables < ActiveRecord::Migration
  def change
    create_table :claimables do |t|
      t.references :corp
      t.string :name, null: false
      t.integer :weight

      t.timestamps null: false
    end
  end
end
