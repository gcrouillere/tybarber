class Amountcalculation
  attr_accessor :order

  def initialize(order)
    @order
  end

  def calculate_amount(order)
    amount_ceramique = 0
    total_weight = 0
    order.basketlines.each do |basketline|
      amount_ceramique += (basketline.ceramique.price) * basketline.quantity
      total_weight += basketline.ceramique.weight
    end
    if total_weight > 0
      tarif_colis = HTTParty.get(
        "https://api.laposte.fr/tarifenvoi/v1?type=colis&poids=#{total_weight}",
        headers: {"X-Okapi-Key" => "lbcSgDW3tBaixIKP/XH0bsMYiKEhPaS6E/gUw+RJmkigGw4+qUNl5uy8/Ilx4eWh" }
      )
      return {total: tarif_colis[0]["price"].to_money + amount_ceramique, port: tarif_colis[0]["price"].to_money}
    else
      {total: 0, port: 0}
    end
  end

end
