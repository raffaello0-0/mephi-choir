class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: [ :index, :make_member, :make_admin ]
  before_action :set_user, only: [ :make_member, :make_admin ]
  def index
    @users = User.all
  end

  def profile
    if current_user.admin?
      @my_events = Event.all.order(event_date: :asc, start_time: :asc)
    else
      @my_events = current_user.events.order(event_date: :asc, start_time: :asc)
    end
  end

  def make_member
    @user.update(role: "member")
    redirect_to users_path, notice: "Пользователь #{@user.email} одобрен как участник"
  end
  def make_admin
    @user.update(role: "admin")
    redirect_to users_path, notice: "Пользователь #{@user.email} одобрен как админ"
  end


  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: "Действие может быть выполнено только админом"
    end
  end
  def set_user
    @user = User.find(params[:id])
  end
end
