class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit; end

  # create new user from admin
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to dashboard_index_path, notice: "[ADMIN] You are now signed in as #{@user.email}"
    else
      render :new
    end
  end

  def update
    @user.update(user_params)
    redirect_to edit_admin_user_path(id: @user.id), notice: 'Usuario fue actualizado exitosamente.'
  end

  def destroy
    email = @user.email
    DestroyUser.new(@user).call
    redirect_to admin_dashboard_index_path, notice: "Usuario '#{email}' fue eliminado."
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :admin)
  end
end
