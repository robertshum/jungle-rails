class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])

    # if user exists and password is correct...
    if @user && @user.authenticate(params[:password])

      # save user id in cookie
      # stay logged in for 'x' time
      session[:user_id] = @user.id
      
      # go home
      redirect_to '/'
    else
      # failed to login
      flash[:error] = 'Invalid email or password'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
