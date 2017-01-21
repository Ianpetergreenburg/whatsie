require 'spec_helper'

describe Recipe do
  describe 'validations' do
    it 'it should require a recipe name' do
      should validate_presence_of :name
    end

    it 'it should require recipe instructions' do
      should validate_presence_of :instructions
    end

    it 'it should require recipe ingredients' do
      should validate_presence_of :ingredients
    end

    it 'it should require recipe source url' do
      should validate_presence_of :url
    end
  end

  describe 'associations' do
    it 'should have many recipe books' do
      should have_many :recipe_books
    end

    it 'should have many users' do
      should have_many :users
    end
  end
end
