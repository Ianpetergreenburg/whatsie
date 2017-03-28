class RecipeBooksController < ApplicationController
  def create
    if current_user == nil
      respond_to do |format|
        format.json { render json: { message: 'Must Be Logged In To Save A Recipe'} }
      end
    else
      @recipe_book = RecipeBook.new(recipe_book_params)
      if @recipe_book.valid?
        @recipe_book.save
        respond_to do |format|
          format.json { render json: { message: 'Recipe Added!'} }
        end
      else
        RecipeBook.find_by(recipe_book_params).destroy
        respond_to do |format|
          format.json { render json: { message: 'Recipe Removed!'} }
        end
      end
    end
  end

  private
  def recipe_book_params
    params.require(:recipe_book).permit(:recipe_id, :user_id)
  end
end
