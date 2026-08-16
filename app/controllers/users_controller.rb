class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: [ :index, :check_user ]
  before_action :set_user, only: [ :check_user ]
  def index
    @users = User.all
  end
  def profile
  end
  def check_user
    @user.update(role: "member")
    redirect_to users_path, notice: "Пользователь #{@user.email} одобрен"
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: "Дейтсвие может быть выполнено только админом"
    end
  end
  def set_user
    @user = User.find(params[:id])
  end
end
