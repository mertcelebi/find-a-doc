class User < ActiveRecord::Base

  # Helpers
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Callbacks
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  # Associations
  has_many :searches, dependent: :destroy

  # Validations
  validates_presence_of :name, :state, :zipcode
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates_length_of :password, minimum: 6

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # Preliminary implementation
    Search.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
