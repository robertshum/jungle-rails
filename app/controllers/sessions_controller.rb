class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create

    if @user = User.authenticate_with_credentials(
      params[:email], params[:password])

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
