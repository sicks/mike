class ChangeCorpCcpIdType < ActiveRecord::Migration
  def change
    change_column :corps, :ccp_id, :string
  end
end
