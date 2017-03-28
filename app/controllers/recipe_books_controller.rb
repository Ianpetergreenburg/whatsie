class RecipeBooksController < ApplicationController
  def create
    if current_user == nil
      respond_to do |format|
        format.json { render json: { message: 'Must Be Logged In To Save A Recipe'} }
      end
    end

    @recipe = Recipe.find_by_id(params[:recipe_book][:recipe_id])
    @recipe_book = RecipeBook.find_by(recipe_id: @recipe.id, user_id: current_user_id)
    if @recipe_book
      p'de;llllleleltleltleteeet'
      @recipe_book.destroy
      respond_to do |format|
        format.json { render json: { message: 'Removed!'} }
      end
    else
      p 'addddddddddddddddddd'
      RecipeBook.create(recipe_id: @recipe.id, user_id: current_user_id)
      respond_to do |format|
        format.json { render json: { message: 'Recipe Added!'} }
      end
    end
  end
end
