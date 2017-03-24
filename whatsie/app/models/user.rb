require 'bcrypt'


class User < ActiveRecord::Base

  has_many :recipe_books
  has_many :recipes, through: :recipe_books

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

end
