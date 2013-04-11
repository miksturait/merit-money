class KudosController < ApplicationController
  before_filter :authenticate_user!

  def create
    # TODO refactor
    if current_user.thanks(params[:kudo])
      render json: {status: 'ok'}
    else
      render json: {status: 'error'}
    end
  end
end
