class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Discard::Model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

  validates :name, presence: true
  after_create :generate_secondary_token

  def active_for_authentication?
    super && !discarded?
  end

  def inactive_message
    "You are not allowed to log in."
  end

  def generate_secondary_token
    # Secure random token (32 characters max)
    token = SecureRandom.urlsafe_base64(24)
    update(secondary_token: token)

    token
  end
end
