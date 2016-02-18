class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :first_name, :last_name, :gender, :user, presence: true

  validates :first_name, :last_name,
            length: { in: 1..24 }

  validates :gender, inclusion: { in: ['Male', 'Female'] }

  validates :day, inclusion: { in: (1..31).to_a }

  validates :month, inclusion: { in: (1..12).to_a }

  validates :year, inclusion: { in: (1900..2000).to_a }

  validates :quote, length: { in: 0..140 },
                    allow_nil: true

  validates :about_me, length: { in: 0..1000 },
                        allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

end
