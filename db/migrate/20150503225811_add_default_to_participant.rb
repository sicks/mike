class AddDefaultToParticipant < ActiveRecord::Migration
  def change
    change_column :participants, :mod, :float, null: false, default: 1.0
  end
end
