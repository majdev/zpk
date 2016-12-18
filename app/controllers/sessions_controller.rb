class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(uname: params[:session][:uname].downcase)
    if user && user.pwdkey==(params[:session][:pwdkey])
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
