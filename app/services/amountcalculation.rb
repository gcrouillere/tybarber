class Amountcalculation
  attr_accessor :order

  def initialize(order)
    @order
  end

  def calculate_amount(order)
    amount_ceramique = 0
    total_weight = 0
    order.basketlines.each do |basketline|
      basketline.ceramique.offer ? ceramique_discount = basketline.ceramique.offer.discount : ceramique_discount = 0
      amount_support = (basketline.with_support ? basketline.ceramique.support_price : 0)
      amount_ceramique += (basketline.ceramique.price * (1 - ceramique_discount)) * basketline.quantity + amount_support * basketline.quantity
      total_weight += basketline.ceramique.weight * basketline.quantity
    end
    if total_weight > 0
      tarif_colis = HTTParty.get(
        "https://api.laposte.fr/tarifenvoi/v1?type=colis&poids=#{total_weight}",
        headers: {"X-Okapi-Key" => ENV['LAPOSTE_API_KEY'] }
      )
      return {total: amount_ceramique, port: tarif_colis[0]["price"].to_money}
    else
      {total: 0, port: 0}
    end
  end

end
