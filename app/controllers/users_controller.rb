class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: User.where(["users.id != ?", current_user.id]).all.map(&:ember_user_info)
  end

  def me
    render json: { current_user: current_user.ember_current_user_info }
  end

 #  def show
 #  	render json: { user: {
 #  		name: 'Wojtek',
 #  		email: 'rrh@op.pl'
 #      received_this_week: [
 #          {
            
 #          }
 #      ]
 #  	}}
	# end

end
