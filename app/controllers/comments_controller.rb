class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def my
    render json: { my_comments: current_user.latest_comments }
  end
end
