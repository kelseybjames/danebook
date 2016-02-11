class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :quote
      t.text :about_me

      t.timestamps null: false
    end
  end
end
