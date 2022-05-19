class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.references :user, foreign_key: true
      t.references :classroom, foreign_key: true
      t.references :classwork, foreign_key: true

      t.timestamps
    end
  end
end
