class OrdersController < ApplicationController
  def current
    @order_products_with_product = @order.order_products.includes(:product)
  end
end