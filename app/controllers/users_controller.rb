class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you #{@user.first_name}, for signing up!"
      redirect_to home_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update user_params
     redirect_to edit_user_path(@user)
    else
     render :edit
    end
  end

  # only the user (or admin) can see their own profile 
  def show
  end

  def destroy #delete account: user and admins in rare occasions
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :first_name,
      :last_name,
      :city,
      :country,
      :email,
      :password,
      :password_confirmation
    )
  end
end
