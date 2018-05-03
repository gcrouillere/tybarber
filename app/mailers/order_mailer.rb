class OrderMailer < ApplicationMailer

  def confirmation_mail_after_order(user, order)
    @user = user
    @order = order
    productqty = @order.basketlines.sum(:quantity)
    mail(to: @user.email, subject: "Confirmation de commande sur Ty Morta")
  end

  def mail_francoise_after_order(user, order)
    @user = user
    @order = order
    mail(to: "#{ENV['EMAIL']}", subject: 'Nouvelle commande recue')
  end

  def send_tracking_after_order(user)
    @user = user
    mail(to: @user.email, subject: 'Numéro de suivi pour votre colis')
  end

end
