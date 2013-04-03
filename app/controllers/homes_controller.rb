class HomesController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

  def about
    render 'about', layout: 'about'
  end
end
