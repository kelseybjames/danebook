class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name,
            length: { in: 1..24 }

  validates :gender, inclusion: {in: ['male', 'female'] }

end
