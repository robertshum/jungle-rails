class User < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  # in real life, we don't something more than 3, but this is for testing.
  validates :password, length: { minimum: 3 }
  validates :password_confirmation, presence: true, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)

    # removes the leading/beginning spaces, not the other kind of 'strip'...
    email.strip!

    # convert to lower cases
    email.downcase!
    
    user = User.find_by_email(email)

    if user && user.authenticate(password)
      return user
    end

    # not authenticated
    return nil
  end
end
