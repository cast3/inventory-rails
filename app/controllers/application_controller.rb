class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    if current_user.role == 1
      redirect_to admin_dashboard_index_path
    else
      dashboard_index_path
    end
  end
end
