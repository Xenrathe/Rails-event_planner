class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    if current_user
      @event = current_user.events.build()
    end
  end

  def create
    if current_user
      @event = current_user.events.build(event_params)
    end
    
    if @event.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :event_type)
  end

end
