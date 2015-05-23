class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.float :amount_payable, null: false
      t.integer :corp_id, null: false
      t.timestamps null: false
    end

    add_column :ops, :payout_id, :integer
  end
end
