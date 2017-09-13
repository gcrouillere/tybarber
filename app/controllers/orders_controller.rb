class OrdersController < ApplicationController

  def create
    @ceramique = Ceramique.find(params[:ceramique].to_i)
    if session[:order].present?
      @order = Order.find(session[:order])
    else
      @order  = Order.create!(
        state: 'pending',
        user: current_user
      )
      session[:order] = @order.id
    end
    if params[:quantity].to_i <= @ceramique.stock
      @basketline = Basketline.create(ceramique: @ceramique, quantity: params[:quantity].to_i, order: @order)
      @ceramique.update(stock: @ceramique.stock - @basketline.quantity)
      @order.update(amount: Amountcalculation.new(@order).calculate_amount(@order))
      flash[:notice] = "Votre panier sera conservé pendant #{(ENV['BASKETDURATION'].to_f * 60).to_i } min"
      redirect_to order_path(@order)
    else
      flash[:alert] = "Désolé, il n'y a que #{@ceramique.stock} en stock"
      redirect_to ceramique_path(@ceramique)
    end
  end

  def show
    @order = Order.where(state: 'pending').find(params[:id])
    @amount = Amountcalculation.new(@order).calculate_amount(@order)
  end

  def destroy
    @order = Order.find(params[:id])
    @basketline = Basketline.find(params[:basketline_id])
    @ceramique = @basketline.ceramique
    @ceramique.update(stock: @ceramique.stock + @basketline.quantity)
    @basketline.destroy
    @order.update(amount: Amountcalculation.new(@order).calculate_amount(@order))
    if @order.basketlines.present?
      redirect_to order_path(@order)
    else
      @order.destroy
      session[:order] = nil
      redirect_to ceramiques_path
    end
  end

end
