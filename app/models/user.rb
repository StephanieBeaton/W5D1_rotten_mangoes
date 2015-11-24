class User < ActiveRecord::Base
  # it adds virtual attributes password
  # and password_confirmation to our user model.
  has_secure_password

  has_many :reviews

end
