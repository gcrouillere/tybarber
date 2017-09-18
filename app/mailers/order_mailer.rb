class OrderMailer < ApplicationMailer

  def confirmation_mail_after_order(user, order, amount)
    @user = user
    @order = order
    @amount = amount
    productqty = @order.basketlines.sum(:quantity)
    mail(to: @user.email, subject: "Confirmation de commande de #{productqty > 1 ? ENV['MODEL'] : ENV['MODEL'][0...-1]}")
  end

  def mail_francoise_after_order(user, order, amount)
    @user = user
    @order = order
    @amount = amount
    mail(to: "#{ENV['EMAIL']}", subject: 'Nouvelle commande recue')
  end

end
