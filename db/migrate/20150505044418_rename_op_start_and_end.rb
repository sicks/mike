class RenameOpStartAndEnd < ActiveRecord::Migration
  def change
    rename_column :ops, :start, :start_time
    rename_column :ops, :end, :end_time
  end
end
