class User < ActiveRecord::Base

  # Helpers
  has_secure_password

  # Callbacks
  before_save { self.email = email.downcase }

  # Validations
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 6

end
