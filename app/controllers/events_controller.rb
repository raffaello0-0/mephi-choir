class EventsController < ApplicationController
    before_action :authenticate_user!, except: [ :index, :show, :day_events]
    before_action :set_event, only: [ :show, :edit, :update, :destroy ]
    before_action :member_or_admin, only: [ :new, :create ]
    before_action :owner_or_admin, only: [ :edit, :update, :destroy ]
    def index
        @events = Event.all
    end
    def show
    end
    def new
        @event = Event.new(event_date: params[:event_date])
    end
    def create
        @event = current_user.events.build(event_params)
        if @event.save
            redirect_to @event
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
    end
    def update
        if @event.update(event_params)
            redirect_to @event
        else
            render :edit, status: :unprocessable_entity
        end
    end
    def destroy
        @event.destroy
        redirect_to events_path
    end

    def day_events
      @events = Event.where(event_date: params[:date]).order(start_time: :asc)
      render json: @events.select(:id, :title, :start_time, :location)
    end

    private
    def event_params
        params.require(:event).permit(:title, :event_type, :event_date, :start_time, :location, :description)
    end
    def member_or_admin
      unless current_user.can_manage_events?
        redirect_to events_path, alert: "Действие может быть выполнено только админом или участником"
      end
    end
    def owner_or_admin
      unless @event.user == current_user || current_user.admin?
        redirect_to events_path, alert: "Действие может быть выполнено только админом или создателем мероприятия"
      end
    end
    def set_event
      @event = Event.find(params[:id])
    end
end
