class User < ActiveRecord::Base
  before_create :generate_token

  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, inverse_of: :user
  has_many :likes, inverse_of: :user
  has_many :comments, inverse_of: :user
  has_many :photos, inverse_of: :user
  
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

  has_secure_password

  validates :email, presence: true

  validates :email, 
            length: { in: 8..48 },
            uniqueness: true

  validates :password,
            length: { in: 4..24 },
            allow_nil: true

  accepts_nested_attributes_for :profile,
                     reject_if: :all_blank

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

  def friends
    friended_users + users_friended_by
  end

  def friends=(friend)
    friended_users << friend
  end

end
