class CreateSurveyCourses < ActiveRecord::Migration
  def self.up
    create_table :survey_courses do |t|
      t.integer :survey_id
      t.integer :course_id

      t.timestamps
    end
  end

  def self.down
    drop_table :survey_courses
  end
end
