class DropSurveyCourses < ActiveRecord::Migration
  def self.up

 	drop_table :survey_courses
	add_column :courses, :course_id, :integer
	
  end

  def self.down

  end
end
