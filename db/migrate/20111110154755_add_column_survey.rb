class AddColumnSurvey < ActiveRecord::Migration
  def self.up
	#remove_column :courses, :course_id
	add_column :surveys, :course_id, :integer
  end

  def self.down

	remove_column :surveys, :course_id
  end
end
