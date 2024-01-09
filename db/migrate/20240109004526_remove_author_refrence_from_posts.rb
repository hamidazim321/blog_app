class RemoveAuthorRefrenceFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :author_id, :integer
  end
end
