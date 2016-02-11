class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name,
            length: { in: 8..24 }

  validates :gender, in: ['male', 'female']

end
