class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email]) #how to include finding by username?

    if user&.authenticate(params[:session][:password])
      flash[:notice] = "Thank you for signing in"
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash.now[:alert] = "Wrong email or password!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out!"
    redirect_to home_path
  end
end
