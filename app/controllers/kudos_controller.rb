class KudosController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: { comments: current_user.latest_comments }
  end

  def create
    kudo = current_user.thanks(params[:kudo])
    unless kudo.new_record?
      render json: {status: 'ok'}
    else
      render json: {status: 'error'}
    end
  end
end
