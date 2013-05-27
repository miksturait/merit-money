class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: current_user.ember_users_for_me
  end

  def me
    render json: {current_user: current_user.ember_current_user_info}
  end
end
