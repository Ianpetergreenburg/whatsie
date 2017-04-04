class SessionsController < ApplicationController
  def login_show
    @user = User.new
    render 'login'
  end

  def login
    @user = User.find_by(username: login_params[:username])
    if @user && @user.authenticate(login_params[:password])
      helpers.log_in(@user)
      redirect_to '/'
    else
      render 'login'
    end
  end

  def logout
    helpers.log_out
    redirect_to '/'
  end

  private
  def login_params
    params.require(:session).permit(:username, :password)
  end

end
