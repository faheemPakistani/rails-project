class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.integer :parent_id, null: true
      t.references :user, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
