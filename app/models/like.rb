class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  validates :likeable_id, uniqueness: { scope: :user_id }
end
