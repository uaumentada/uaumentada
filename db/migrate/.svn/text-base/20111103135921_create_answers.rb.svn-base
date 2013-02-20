class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string :id_user
      t.integer :id_survey
      t.integer :id_question
      t.text :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
