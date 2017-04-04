

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      helpers.log_in(@user)
      redirect_to '/'
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @profile_id = params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
