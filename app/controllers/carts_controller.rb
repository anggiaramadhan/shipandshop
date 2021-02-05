class CartsController < ApplicationController
  def create
    cart = ShoppingCart::Create.new(cart_params).call
    render json: cart
  end

  def update
    cart = ShoppingCart::Update.new(cart_params).call
    render json: cart
  end

  private

  def cart_params
    params.permit(
      :id,
      :user_id,
      line_items_attributes: %i[id product_id store_id variant_id]
    )
  end

end
