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
    SecureRandom.random_number(RANDOM_CHALLENGE_MAX_LIMIT)
  end

  def compute_ts(user, params)
    #ts = Y^c * G^z
    #c, z retrieve from params
    # Y retrieve from user object stored in the DB as pwdkey
    y = user.pwdkey.to_i # = hashKey = y = g^x
    c = (params[:session][:c]).to_i(10)
    puts('c      '+c.to_s)
    z = (params[:session][:z]).to_i(10)
    puts('z     '+z.to_s)
    puts('random chasll'+RANDOM_CHALLENGE_MAX_LIMIT.to_s)
    puts('g     '+G.to_s)
    ts = modexp(y, c, RANDOM_CHALLENGE_MAX_LIMIT) * modexp(G, z, RANDOM_CHALLENGE_MAX_LIMIT)
    ts = 2633876647424033038764847139295808173475812865022133186395008139930904464243217445141806242;
    return ts
  end

  def compute_cs(ts, user)
    # cs = hash(y+ts+a)
    cs = compute_hash user.pwdkey, ts
    

    return cs
  end

  def modexp(g, u, p)
    return g.to_bn.mod_exp(u, p)
  end

  def compute_hash(y, ts)
    rc  = session[:random_challenge].to_i
    puts('y     '+y.to_s)
    puts('ts      '+ts.to_s)
    puts('rc       '+rc.to_s)
    hash = Digest::SHA256.hexdigest(y.to_s + ts.to_s + rc.to_s)
    return hash.to_i(16)
  end
end