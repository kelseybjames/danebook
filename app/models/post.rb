class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_likings, dependent: :destroy
  has_many :liking_users, through: :post_likings,
                          source: :user,
                          inverse_of: :posts
  has_many :comments, as: :commentable,
                      dependent: :destroy
  accepts_nested_attributes_for :comments

  validates :body, presence: true

  def self.to_s
    'Post'
  end
end
