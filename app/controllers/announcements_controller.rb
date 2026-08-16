class AnnouncementsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_only, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  def index
    @announcements = Announcement.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @announcement = Announcement.new()
  end

  def create
    @announcement = current_user.announcements.build(announcement_params)
    if @announcement.save
      redirect_to @announcement
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      redirect_to @announcement
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @announcement.destroy
    redirect_to announcements_path
  end

  private
  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end
  def set_announcement
    @announcement = Announcement.find(params[:id])
  end
end
