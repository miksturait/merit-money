class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end


  def create
    auth = request.env["omniauth.auth"]
    if AllowedUser.where(email: auth['info']['email']).exists?
      user = User.where(:provider => auth['provider'],
                        :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      if user.email.blank?
        redirect_to edit_user_path(user), :alert => "Please enter your email address."
      else
        redirect_to root_url, :notice => 'Signed in!'
      end
    else
      redirect_to about_url, :alert => "Authentication error: sorry your email is not in the list"
    end
  end

  def destroy
    reset_session
    redirect_to about_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to about_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
