class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = "Incorrect User/Password"
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
