class User < ApplicationRecord
  validates :email, uniqueness: true 
  validates_format_of :email, with: /@/, on: :create, message: "电子邮箱无效"
  validates :password_digest, presence: true
end
