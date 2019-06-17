class ApplicationController < ActionController::Base
  # DEVISE :
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :retrieve_admin
  before_action :check_theme
  before_action :uniq_categories
  layout :layout_by_resource
  after_action :store_location

  def default_url_options
  { host: ENV["HOST"] || "localhost:3000", locale: I18n.locale }
  end

  def set_locale
    if params[:change].present? || params[:locale].present?
      I18n.locale = params[:locale]
    else
      locale_trial = extract_locale_from_accept_language_header
      ["fr", "en"].include? locale_trial ? I18n.locale = locale_trial : I18n.locale = "fr"
    end
  end

  def retrieve_admin
    @admin = ::User.where(admin: true).includes(:logophoto_files).first
  end

  def check_theme
    @active_theme = ::Theme.where(active: true).first || ::Theme.create(active: true, name: "default")
  end

  def uniq_categories
    @top_categories = ::TopCategory.joins(:categories).distinct
    if params[:top_category]
      query = params[:top_category]
      @top_category = TopCategory.i18n.find_by(name: query)
      @uniq_categories = ::Category.joins(:top_category).merge(TopCategory.i18n { name.matches(query) })
    else
      @uniq_categories = ::Category.joins(:top_category)
    end
  end

  #DEVISE methods:

  # 0 - Layout for devise
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

    # 1 - Rendering current page after sign-in/up
  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
    session[:dev_redirection_default] = "https://www.creermonecommerce.fr"
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referer
  end

  def after_sign_in_path_for(resource)
    session[:signincount] ? session[:signincount] += 1 : session[:signincount] = 0
    session[:previous_url] || root_path
  end

  # 2 - Permitted parameters for sign_in/up
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name,
      :last_name,
      :adress,
      :zip_code,
      :city,
      :country,
      :provider,
      :uid,
      :facebook_picture_url,
      :token,
      :token_expiry,
      :consented
      ])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name,
      :last_name,
      :adress,
      :zip_code,
      :city,
      :country,
      ])
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
  end

  protected

  def authenticate_user!(options={})
    session[:signincount] ||= 0
    unless user_signed_in?
      if session[:signincount] < 1
        store_location_for(:user, request.url)
        redirect_to new_user_registration_path and return
      else
        store_location_for(:user, request.url)
        redirect_to  new_user_session_path and return
      end
    end
    super(options)
  end

end
