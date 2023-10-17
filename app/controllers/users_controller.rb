class UsersController < ApplicationController
  before_action :authenticate_user! 

  def show
    @user = current_user
    @owned_adventures = @user.adventures
    @attended_adventures = @user.characters.flat_map { |character| character.attended_adventures.includes(:adventure) }
  end
end
