class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[index destroy]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Usuario ha sido actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to '/', notice: 'Usuario ha sido eliminado exitosamente.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def authorize_admin
    redirect_to '/', alert: 'Acceso denegado' unless current_user.role == 'admin'
  end
end
