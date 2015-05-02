class AddMainToUsers < ActiveRecord::Migration
  def change
    add_column :users, :main_id, :string
  end
end
