class User < ActiveRecord::Base
  # it adds virtual attributes password
  # and password_confirmation to our user model.
  has_secure_password

  validates :email,
    presence: true

  validates :firstname,
    presence: true

  validates :lastname,
    presence: true

  validates :password,
    length: { in: 6..20 }, on: :create

  has_many :reviews

  def full_name
    "#{firstname} #{lastname}"
  end

end
