class AddPhotoIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_id, :integer
    add_column :users, :cover_photo_id, :integer
    add_index :users, :avatar_id
    add_index :users, :cover_photo_id
  end
end
