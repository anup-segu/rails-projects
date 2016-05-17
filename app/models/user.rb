class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true

  has_many :notes, dependent: :destroy

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return user if user.is_password?(password)
  end

  def generate_sesion_token
    self.session_token = SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
