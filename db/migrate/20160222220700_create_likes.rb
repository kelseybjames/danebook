class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps null: false
    end
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
