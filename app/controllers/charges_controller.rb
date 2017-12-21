class ChargesController < ApplicationController
  def new; end

  def create
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: @order.total,
      currency: "usd",
    )

    @order.order_products.each do |order_product|
      order_product.product.stock_quantity -= order_product.quantity
      order_product.product.save
    end

    @order.update(placed_at: Time.now)
    OrderMailer.order_placed_email(@order).deliver_now
    expire_shopping_cart
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
