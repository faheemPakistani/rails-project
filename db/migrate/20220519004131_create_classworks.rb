class CreateClassworks < ActiveRecord::Migration[5.2]
  def change
    create_table :classworks do |t|
      t.integer :parent_id, null: true
      t.integer :work_type
      t.references :user, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
