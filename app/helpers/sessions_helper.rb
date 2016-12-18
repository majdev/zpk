module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def user_id_logged_in?(id)
    logger.info session[:user_id]
    logger.info id
    session[:user_id]==id
      
  end

 # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def generate_random
    SecureRandom.random_number(RANDOM_CHALLENGE)
  end
end