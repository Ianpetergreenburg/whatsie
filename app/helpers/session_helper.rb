module SessionHelper

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def current_user_id
    session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def current_user_admin
    return false unless current_user
    current_user.admin?
  end


  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    current_user = nil
  end

  def can_edit?(recipe)
    current_user_admin || current_user && recipe.chef = current_user
  end

  alias_method :can_delete?, :can_edit?

end
