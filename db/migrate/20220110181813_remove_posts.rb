class RemovePosts < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :reports, :posts
  end
end
