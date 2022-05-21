class AddDatetimeToClasswork < ActiveRecord::Migration[5.2]
  def change
    add_column :classworks, :expiry, :datetime
  end
end
