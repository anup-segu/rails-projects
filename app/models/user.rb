class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :password, presence: true, limit: 6
  validates :email, uniqueness: true

  def generate_sesion_token
    self.session_token = SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.base64(16)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
