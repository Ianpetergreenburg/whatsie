require 'spec_helper'

describe RecipeBook do
  describe 'validations' do
    it 'it should require a recipe id' do
      should validate_presence_of :recipe_id
    end

    it 'it should require user id' do
      should validate_presence_of :user_id
    end
  end

  describe 'associations' do
    it 'should belong to a recipe' do
      should belong_to :recipe
    end

    it 'should belong to a user' do
      should belong_to :user
    end
  end
end
