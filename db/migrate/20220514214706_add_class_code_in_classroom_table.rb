class AddClassCodeInClassroomTable < ActiveRecord::Migration[5.2]
  def change
    add_column :classrooms, :class_code, :string, null: true
  end
end
