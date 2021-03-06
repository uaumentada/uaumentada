class NewQuestionTable < ActiveRecord::Migration
  def self.up
    
    drop_table :questions
    
    create_table :questions do |t|
      t.integer :question_type
      t.string :question
      t.boolean :mandatory
      t.string :help
      t.string :answers
      t.integer :question_number
      t.integer :survey_id
      

      t.timestamps
    end
  
  end

  def self.down
  
    drop_table :questions
    
    create_table :questions do |t|
      t.integer :question_type
      t.string :question
      t.boolean :mandatory
      t.string :help
      t.string :answers
      t.integer :question_number
      t.string :survey_id

      t.timestamps
    end
  
  end
end
