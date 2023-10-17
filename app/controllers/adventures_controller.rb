class AdventuresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @adventures = Adventure.all

    #Filter by public only
    @adventures = @adventures.is_public
    
    # Filter: Past vs upcoming
    if params[:time].present?
      @adventures = params[:time] == 'upcoming' ? @adventures.upcoming : @adventures.past
    end
    
      # Filter: Ruleset
    if params[:ruleset] == 'active_character' && current_user && current_user.active_character
      @adventures = @adventures.by_ruleset(active_character.ruleset)
    elsif params[:ruleset] != 'all' && params[:ruleset] != 'active_character'
      @adventures = @adventures.by_ruleset(params[:ruleset])
    end
 
    # Filter: open
    @adventures = @adventures.open if params[:vacancy].present?
    # Filter: by level
    if params[:min_level].present? && params[:max_level].present?
      @adventures = @adventures.by_level_range(params[:min_level], params[:max_level])
    end
    # Filter: by platform (in person vs VTT)
    if params[:platform].present?
      @adventures = params[:platform] == 'virtual' ? @adventures.virtual : @adventures.in_person
    end
    @adventures_test = @adventures
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def new
    @adventure = current_user.adventures.build() if current_user
  end

  def create
    @adventure = current_user.adventures.build(new_adventure_params) if current_user
    
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

  def new_adventure_params
    params.require(:adventure).permit(:name, :date, :ruleset, :module, :description, :platform, 
                                      :max_seats, :min_age, :min_level, :max_level, :address, :is_private)
  end

end
