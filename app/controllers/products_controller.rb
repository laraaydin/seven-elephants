class ProductsController < ApplicationController
  def index
    @products =
      if params[:search_term]
        Product.search do
          fulltext params[:search_term]
          spellcheck count: 3
        end.results
      else
        Product.all.order(created_at: :asc)
      end
  end

  def show
    @product = Product.find(params[:id])
    @order_product = OrderProduct.new(product: @product)
    @in_stock = @product.stock_quantity - @order.quantity_for_product(@product)
  end
end
