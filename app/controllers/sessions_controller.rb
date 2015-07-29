class SessionsController < ApplicationController
  skip_before_filter :authenticate, :except => :destroy

  def new

  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id session. This also saves in cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    # setting the user_id in session variable nil
    session[:user_id] = nil
    redirect_to '/login'
  end
end
