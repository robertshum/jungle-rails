class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to [:new, :user]
    end
  end

  private

  # password and password confirmation are NOT naturally found in  the user table.  They come implicitly (yes more black magic...) from has_secure_password in the User Model.  It also encryps the password before saving to the DB in the column of password_digest.
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
