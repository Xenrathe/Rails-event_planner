class AdventuresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :attend]

  def intro
    @adventures = Adventure.upcoming.is_public.order(date: :asc).limit(5)
  end

  def index
    @adventures = Adventure.all

    #Filter by public only
    @adventures = @adventures.is_public

    if params[:match_active_character].present? && current_user
      puts "Active char enabled"
      @adventures = @adventures.compatible_with_active_character(current_user)
      render :index
      return
    end

    puts "Active char not enabled"
    
    # Filter: Past vs upcoming
    if params[:time].present?
      @adventures = params[:time] == 'upcoming' ? @adventures.upcoming : @adventures.past
    end
    
    # Filter: Ruleset
    if params[:ruleset].present?
      if params[:ruleset] == 'active_character' && current_user && current_user.active_character
        @adventures = @adventures.by_ruleset(active_character.ruleset)
      elsif params[:ruleset] != 'all' && params[:ruleset] != 'active_character'
        @adventures = @adventures.by_ruleset(params[:ruleset])
      end
    end
 
    # Filter: open
    @adventures = @adventures.open if params[:vacancy].present?

    # Filter: by level
    min_level = params[:min_level].present? ? params[:min_level] : 0
    max_level = params[:max_level].present? ? params[:max_level] : 99
    @adventures = @adventures.by_level_range(min_level, max_level)

    # Filter: by platform (in person vs VTT)
    if params[:platform].present?
      @adventures = params[:platform] == 'virtual' ? @adventures.virtual : @adventures.in_person
    end
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def update
    @adventure = Adventure.find(params[:id])

    # Only allow creators to edit the adventure
    if current_user && @adventure.creator_id == current_user.id
      if @adventure.update(adventure_params)
        flash[:notice] = "Adventre successfully edited."
        redirect_to adventure_path(@adventure)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = "You are not this adventure's creator."
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @adventure = current_user.adventures.build() if current_user
  end

  def create
    @adventure = current_user.adventures.build(adventure_params) if current_user
    
    if @adventure.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @adventure = Adventure.find(params[:id])
    if current_user && current_user.id == @adventure.creator_id 
      if @adventure.destroy
        flash[:notice] = 'Adventure was successfully deleted.'
      else
        flash[:alert] = 'Failed to delete the adventure.'
      end
    else
      flash[:alert] = 'Only adventure creator can destroy it.'
    end
    redirect_to adventures_path
  end

  def attend
    @adventure = Adventure.find(params[:id])

    if !current_user || current_user.active_character.nil?
      flash[:alert] = "Error: No active character"
      render :show, status: :unprocessable_entity
      return
    end

    # Remove attendance if already attending
    if @adventure.attendees.include?(current_user.active_character)
      current_user.active_character.attended_adventures.delete(@adventure)
      redirect_to @adventure, notice: "#{current_user.active_character.name} is no longer attending this adventure."
      return
    end

    # Otherwise attempt to attend
    if current_user.active_character.level >= @adventure.min_level && current_user.active_character.level <= @adventure.max_level
      if current_user.birthdate + @adventure.min_age.years < Time.now
        if @adventure.attendees.count < @adventure.max_seats
          current_user.active_character.attended_adventures << @adventure
          redirect_to @adventure, notice: "#{current_user.active_character.name} is now attending this adventure."
        else
          flash[:alert] = "Adventure is full."
          render :show, status: :unprocessable_entity
        end
      else
        flash[:alert] = "You do not meet minimum age requirements."
        render :show, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Character level is not within min/max of adventure."
      render :show, status: :unprocessable_entity
    end
  end

  private

  def adventure_params
    params.require(:adventure).permit(:name, :date, :ruleset, :module, :description, :platform, 
                                      :max_seats, :min_age, :min_level, :max_level, :address, :is_private)
  end

end
