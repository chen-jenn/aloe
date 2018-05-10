class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy, :show]

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

  # only the user (or admins) can see their own profile
  def show
    @user = current_user
    @individual_plants = @user.individual_plants
  end

  #delete account: user and admins in rare occasions
  def destroy
    @user = current_user
    @user.destroy
    session[:user_id] = nil
    flash[:alert] = "Account has been deleted"
    redirect_to plants_path
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

  def find_user
    @user = User.find params[:id]
  end

  def authorize_user!
    unless can?(:manage_self, @user)
      flash[:alert] = 'Access Denied'
      redirect_to plants_path
    end
  end
end
