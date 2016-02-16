class User < ActiveRecord::Base
  before_create :generate_token

  has_one :profile, dependent: :destroy
  has_many :posts, inverse_of: :user
  has_many :post_likings, inverse_of: :user
  has_many :liked_posts, through: :post_likings,
                         source: :post
                        

  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  accepts_nested_attributes_for :profile,
                     reject_if: :all_blank

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

end
