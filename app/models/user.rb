class User < ActiveRecord::Base
  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true
end
