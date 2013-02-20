class EditAnswersTable < ActiveRecord::Migration
  def self.up
    rename_column :answers, :id_user, :user_id
    rename_column :answers, :id_survey, :survey_id
    rename_column :answers, :id_question, :question_id
  end

  def self.down
  
    rename_column :answers, :user_id, :id_user
    rename_column :answers, :survey_id, :id_survey
    rename_column :answers, :question_id, :id_question
  
  end
end
