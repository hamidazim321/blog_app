class RemoveUserAndPostReferencesFromLikes < ActiveRecord::Migration[7.1]
  def change
    remove_column :likes, :user_id, :integer
    remove_column :likes, :post_id, :integer
  end
end
