class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
<<<<<<< HEAD
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash.now[:success] = 'Login success!'
      redirect_back_or user
=======
      session[:user_id] = user.id
      # flash[:success] = "You have successfully logged in."
      # redirect_to root_path
      redirect_to user_path(session[:user_id])
      flash[:success] = "You have successfully logged in."
>>>>>>> origin
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
