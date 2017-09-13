class OrderMailer < ApplicationMailer

  def confirmation_mail_after_order(user, order, amount)
    @user = user
    @order = order
    @amount = amount
    mail(to: @user.email, subject: 'Confirmation de commande de céramique')
  end

  def mail_francoise_after_order(user, order, amount)
    @user = user
    @order = order
    @amount = amount
    mail(to: 'nugierfrancoise@yahoo.fr', subject: 'Nouvelle commande recue')
  end

end
