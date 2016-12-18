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

 # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def generate_random
    SecureRandom.random_number(RANDOM_CHALLENGE)
  end

  def compute_ts(user, params)
    #ts = Y^c * G^z
    #c, z retrieve from params
    # Y retrieve from user object stored in the DB as pwdkey
    y = user.pwdkey # = hashKey = y = g^x
    c = params[:session][:c]
    z = params[:session][:z]
    ts = (y^c)*(g^z) #is it like this? have to modify this
  end

  def compute_cs(ts, user)
    # cs = hash(y+ts+a)
    
  end
end