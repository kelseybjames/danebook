class AddDateNameGenderToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
    add_column :profiles, :day, :integer
    add_column :profiles, :month, :integer
    add_column :profiles, :year, :integer
    add_column :profiles, :gender, :string
  end
end
