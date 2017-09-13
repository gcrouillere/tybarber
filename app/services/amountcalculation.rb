class Amountcalculation
  attr_accessor :order

  def initialize(order)
    @order
  end

  def calculate_amount(order)
    amount = 0
    order.basketlines.each do |basketline|
      amount += basketline.ceramique.price * basketline.quantity
    end
    amount
  end

end
