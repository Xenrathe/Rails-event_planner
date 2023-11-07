class CharactersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    @character = Character.find(params[:id])
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])

    # Only allow users to edit their own characters
    if current_user && @character.user_id == current_user.id
      if @character.update(character_params)
        flash[:notice] = "Character successfully edited."
        redirect_to character_path(@character)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = "You cannot edit other users' characters."
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    if current_user
      @character = current_user.characters.build()
    end
  end

  def create
    @character = current_user.characters.build(character_params) if current_user
    
    if @character.save
      current_user.active_character = @character if current_user.active_character.nil?
      redirect_to character_path(@character)
    else
      flash[:alert] = "Error saving new character."
      render 'new'
    end
  end

  def set_active
    @character = Character.find(params[:id])
    if current_user&.characters&.include?(@character)
      current_user.active_character = @character
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Cannot change another user's active char"
      redirect_to user_path(current_user), status: :unprocessable_entity
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :race, :character_class, :level, :gender, :backstory, :ruleset, :portrait_path)
  end

end
