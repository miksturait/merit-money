class KudosController < ApplicationController
  before_filter :authenticate_user!

  def create
    # TODO refactor
    user = User.find(params[:user_id])
    kudo = current_user.thanks(user, {value: 1})
    if kudo.valid?
      render json: 'ok'
    else
      render json: kudo.errors
    end
  end
end
