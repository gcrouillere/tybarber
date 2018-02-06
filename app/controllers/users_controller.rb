class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:subscribe]

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to request.referrer
  end

  def subscribe
    unless session[:email]
      if Regexp.new('\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,}\z').match(params[:user][:email])
        @user = User.create(subscribe_params)
        SubscribeMailer.subscribe(@user, @admin).deliver_now
        @user.destroy
        session[:email] = params[:user][:email]
        flash[:notice] = "Vous êtes bien inscrit(e) à la newsletter"
        redirect_to request.referrer
      end
    end
  end

  private

   def user_params
    params.require(:user).permit(
      :id,
      :first_name,
      :last_name,
      :email,
      :adress,
      :zip_code,
      :city,
      :provider,
      :uid,
      :facebook_picture_url,
      :token,
      :token_expiry,
      :productphoto,
      :avatarphoto,
      :cityphoto,
      :productphotomobile,
      :lessonphoto,
      :logophoto,
      homerightphotos: []
    )
  end

  def subscribe_params
    params.require(:user).permit(:email, first_name: "John", last_name: "Doe")
  end

end
