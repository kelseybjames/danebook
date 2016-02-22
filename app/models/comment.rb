class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: 'User'
  has_many :likes, as: :likeable,
                   dependent: :destroy

  validates :body, :author, presence: true
end
