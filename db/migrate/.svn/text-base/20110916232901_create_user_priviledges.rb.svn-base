class CreateUserPriviledges < ActiveRecord::Migration
  def self.up
    create_table :user_priviledges do |t|
      t.string :email
      t.string :id_priv

      t.timestamps
    end
  end

  def self.down
    drop_table :user_priviledges
  end
end
