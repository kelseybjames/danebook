class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_likings
  has_many :liking_users, class_name: 'User',
                          through: :post_likings,
                          inverse_of: :posts
end
