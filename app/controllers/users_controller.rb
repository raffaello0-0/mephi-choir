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
      @my_announcements = Announcement.all.order(created_at: :desc)
    else
      @my_events = current_user.events.order(event_date: :asc, start_time: :asc)
      @my_announcements = []
    end
  end

  def make_member
    @user.update(role: "member")
    redirect_to users_path, notice: "User #{@user.email} is approved as a member"
  end
  def make_admin
    @user.update(role: "admin")
    redirect_to users_path, notice: "User #{@user.email} is approved as an admin"
  end


  private

  def set_user
    @user = User.find(params[:id])
  end
end
