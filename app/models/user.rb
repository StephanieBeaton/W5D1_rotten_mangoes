class User < ActiveRecord::Base
  # it adds virtual attributes password
  # and password_confirmation to our user model.
  has_secure_password

  has_many :reviews

  def full_name
    "#{firstname} #{lastname}"
  end

end
