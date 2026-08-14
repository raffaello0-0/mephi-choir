class AnnouncementsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @announcements = Announcement.all.order(created_at: :desc)
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new()
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      redirect_to @announcement
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to @announcement
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to announcements_path
  end

  private
  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end
end
