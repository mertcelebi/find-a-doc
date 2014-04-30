class User < ActiveRecord::Base

  # Helpers
  has_secure_password

  # Callbacks
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  # Validations
  validates_presence_of :name, :email, :state, :zipcode
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 6

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
