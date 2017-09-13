class AppSpecificRegistration::RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    if session[:order].present? || session[:previous_url].include?("payments/new?order") || session[:previous_url].include?("lessons/")
      session[:previous_url]
    else
      root_path
    end
  end

end
