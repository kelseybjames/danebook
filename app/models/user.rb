class User < ActiveRecord::Base
  before_create :generate_token

  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, inverse_of: :user
  has_many :likes, inverse_of: :user
  has_many :comments, inverse_of: :user
  has_many :photos, inverse_of: :user, 
            dependent: :destroy
  
  has_many :initiated_friendings, 
            foreign_key: :friender_id,
            class_name: "Friending"

  has_many :friended_users,
           through: :initiated_friendings,
           source: :friend_recipient

  has_many :received_friendings,
           foreign_key: :friend_id,
           class_name: "Friending"

  has_many :users_friended_by,
           through: :received_friendings,
           source: :friend_initiator

  belongs_to :avatar, class_name: 'Photo'

  belongs_to :cover_photo, class_name: 'Photo'

  has_secure_password

  validates :email, presence: true

  validates :email, 
            length: { in: 8..48 },
            uniqueness: true

  validates :password,
            length: { in: 4..24 },
            allow_nil: true

  validate :avatar_belongs_to_user

  validate :cover_photo_belongs_to_user

  accepts_nested_attributes_for :profile,
                     reject_if: :all_blank

  def friends
    # TODO: Change to SQL
    friended_users + users_friended_by
  end

  def friends=(friend)
    friended_users << friend
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def newsfeed(last_n=10)
    # Collect user's friends.
    post_creators = []
    friends.each { |friend| post_creators << friend.id }
    # Collect posts from those friends, order created_at DESC.
    Post.where('user_id IN (?)', post_creators).order('created_at DESC').limit(last_n)
  end

  def self.search(query)
    if query
      where('email LIKE ?', "%#{query}%")
    else
      where("")
    end
  end

  private

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.delay.welcome(user)
    # TODO: Add link to timeline in mailer
  end

  def avatar_belongs_to_user
    avatar.user_id == id if avatar
  end

  def cover_photo_belongs_to_user
    cover_photo.user_id == id if cover_photo
  end
end
