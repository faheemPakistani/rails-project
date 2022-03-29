# frozen_string_literal: true

# adding new column
class AddStatusToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :status, :integer
  end
end
