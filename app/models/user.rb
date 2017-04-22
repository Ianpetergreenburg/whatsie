require 'bcrypt'


class User < ActiveRecord::Base

  has_many :recipe_books
  has_many :saved_recipes, through: :recipe_books, source: :recipe
  has_many :created_recipes, class_name: 'Recipe', foreign_key: :chef_id

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  def admin?
    self.admin
  end

end
