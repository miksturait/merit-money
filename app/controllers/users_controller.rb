class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: users
  end

  def me
    render json: {current_user: current_user.ember_current_user_info}
  end

  private

  def users
    User.where(["users.id != ?", current_user.id]).all.collect do |user|
      user.ember_user_info_for_current_user(current_user)
    end
  end

end
