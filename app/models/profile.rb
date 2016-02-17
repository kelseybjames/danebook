class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name,
            length: { in: 1..24 }

  validates :gender, inclusion: { in: ['Male', 'Female'] }

  validates :first_name, :last_name, :gender, :user, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

end
