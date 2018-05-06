class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.order(id: :asc)
  end

  private
  def authorize_admin!
    unless current_user.is_admin?
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end

end
