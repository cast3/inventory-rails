class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_session_role, only: %i[new create]

  private

  def check_session_role
    return if current_user && current_user.role == 'tu_rol_especifico'

    flash[:alert] = 'No tienes permiso para registrarte.'
    redirect_to root_path
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
