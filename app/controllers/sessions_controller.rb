require 'digest'
class SessionsController < ApplicationController
  def new
    # here add random challenge
    @random_challenge = generate_random
    puts @random_challenge
    hash = Digest.SHA256.digest @random_challenge
    puts hash.to_i(16)
  end

  def create
  	user = User.find_by(uname: params[:session][:uname].downcase)
    ts = compute_ts user,params
    puts ts

    #now compute c' = hash(y+ts+randomm_challenge)
    cs = compute_cs ts,user

    #check if cs == cc and usernames match only then athenticate
    if user && cs==(params[:session][:c])
    	log_in user
      	redirect_to user
    else
     flash.now[:danger] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
  	log_out
    redirect_to root_url
  end
end
