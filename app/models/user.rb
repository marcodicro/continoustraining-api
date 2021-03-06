class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, format: Devise.email_regexp
  validates :first_name, :last_name, :gender, :email, presence: true
  has_many :trainings, dependent: :destroy

  enum gender: { male: 0, female: 1 }

  before_validation :generate_verification_code, on: :create

  def generate_verification_code
    self.verification_code = AuthenticableEntity.verification_code
  end
end
