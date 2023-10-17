class AdventuresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @upcoming_adventures = Adventure.upcoming
    @past_adventures = Adventure.past
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def new
    if current_user
      @adventure = current_user.adventures.build()
    end
  end

  def create
    if current_user
      @adventure = current_user.adventures.build(adventure_params)
    end
    
    if @adventure.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  def attend
    @adventure = Adventure.find(params[:id])
    current_user.attended_adventures << @adventure
    redirect_to @adventure, notice: 'You are now attending this adventure.'
  end

  private

  def adventure_params
    params.require(:adventure).permit(:name, :date, :event_type)
  end

end
