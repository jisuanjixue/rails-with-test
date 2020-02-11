class User < ApplicationRecord
  has_many :products, class_name: "product", dependent: :destroy
  has_secure_password
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/, on: :create, message: '电子邮箱无效'
  validates :password_digest, presence: true
end
