class UsersController < ApplicationController
  before_action :authenticate_user! 

  def show
    @user = current_user
    @adventures = current_user.adventures
  end
end
