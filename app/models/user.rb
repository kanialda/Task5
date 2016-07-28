class User < ActiveRecord::Base
  before_create :add_activation_token
  def add_activation_token
    self.activation_token = SecureRandom.urlsafe_base64
    self.activation_status = "not activated"
  end

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create,
 length: { minimum: 5 },
 confirmation: true
end
