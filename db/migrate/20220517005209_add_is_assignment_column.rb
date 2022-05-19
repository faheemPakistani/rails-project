class AddIsAssignmentColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :status, :integer, null: true
  end
end
