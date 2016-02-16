class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_likings
  has_many :liking_users, through: :post_likings,
                          source: :user,
                          inverse_of: :posts
  has_many :comments, as: :commentable
end
