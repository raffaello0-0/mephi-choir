class PagesController < ApplicationController
  def home
    @recent_announcements = Announcement.order(created_at: :desc).limit(3)
    @new_events = Event.where("event_date > ?", Date.today).order(event_date: :asc, start_time: :asc).limit(5)
  end
end
