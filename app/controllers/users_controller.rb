class UsersController < ApplicationController
  before_action :authenticate_user! 

  def show
    @user = current_user
    @events = current_user.events
  end
end
