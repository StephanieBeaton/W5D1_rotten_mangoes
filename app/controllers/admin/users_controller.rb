class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "User was successfully created, #{@user.firstname}!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy

    # Mailers are really just another way to render a view.
    # Instead of rendering a view and sending out the HTTP protocol,
    # they are just sending it out through the email protocols instead.
    # Due to this, it makes sense to just have your controller tell the Mailer
    # to send an email when a user is successfully created.

    # Mailer --
    # app/mailers/user_mailer.rb

    # just edit the app/controllers/admin/users_controller.rb
    # make it instruct the UserMailer to deliver an email to the user being deletedd
    # by an Admin
    # by editing the destroy action
    # and inserting a call to UserMailer.welcome_email
    # right before the user is successfully deleted.


    @user = User.find(params[:id])

    # Tell the UserMailer to send a welcome email after desroy
    temp = UserMailer.account_deleted_notice_email(@user)

    temp.deliver

    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end


