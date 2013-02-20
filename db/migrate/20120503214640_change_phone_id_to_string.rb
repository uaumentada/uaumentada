class ChangePhoneIdToString < ActiveRecord::Migration
  def self.up
    change_column :tokens, :phone_id, :string
  end

  def self.down
    change_column :tokens, :phone_id, :integer
  end
end
