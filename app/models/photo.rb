class Photo < ActiveRecord::Base
  belongs_to :user

  has_many :comments, as: :commentable,
                      dependent: :destroy
                      
  has_many :likes, as: :likeable,
                   dependent: :destroy

  has_attached_file :image, styles: { 
                    medium: "300x300", 
                    thumb: "100x100" }, 
                    s3_host_name: "s3-us-west-2.amazonaws.com"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.to_s
    'Photo'
  end

  def photo_from_url(url)
    self.photo = open(url)
  end
end
