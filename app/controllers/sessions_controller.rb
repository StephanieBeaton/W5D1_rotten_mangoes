class SessionsController < ApplicationController

# Already, things are a bit different here.
# This is largely due to the fact that
# we're not actually dealing with a model.
# (It's important to note that "resources" usually refer to models but not always.)

  def new
  end


  # It's a simple form_tag which will submit a POST request to the sessions_path,
  #  triggering our sessions#create action

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin]   = user.admin
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to movies_path, notice: "Adios!"
  end

end
