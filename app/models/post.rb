class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable,
                      dependent: :destroy
                      
  has_many :likes, as: :likeable,
                   dependent: :destroy

  accepts_nested_attributes_for :comments

  validates :body, :user, presence: true

  validates :body, length: { in: 1..1000 }

  def self.to_s
    'Post'
  end
end
