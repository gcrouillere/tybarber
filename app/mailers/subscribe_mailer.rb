class SubscribeMailer < ApplicationMailer

  def subscribe(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, subject: "Inscription à la newsletter")
  end

end
