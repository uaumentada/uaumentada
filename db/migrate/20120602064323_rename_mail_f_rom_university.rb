class RenameMailFRomUniversity < ActiveRecord::Migration
    def self.up
    rename_column :universities, :mail, :email
  end

  def self.down
    rename_column :universities, :email, :mail
  end
end
