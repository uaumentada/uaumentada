class CreateUserCourses < ActiveRecord::Migration
  def self.up
    create_table :user_courses do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_courses
  end
end
