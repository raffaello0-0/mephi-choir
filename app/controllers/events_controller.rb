class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    def index
        @events = Event.all
    end
    def show
        @event = Event.find(params[:id])
    end
    def new
        @event = Event.new(event_date: params[:event_date])
    end
    def create
        @event = Event.new(event_params)
        if @event.save
            redirect_to @event
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
        @event = Event.find(params[:id])
    end
    def update
        @event = Event.find(params[:id])
        if @event.update(event_params)
            redirect_to @event
        else
            render :edit, status: :unprocessable_entity
        end
    end
    def destroy
        @event = Event.find(params[:id])
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
end
