class CartsController < ApplicationController
  def create
    cart = ShoppingCart::Create.new(cart_params).call
    render json: cart
  end

  def update
  end

  def destroy
  end

  private

  def cart_params
    params.permit(
      :user_id,
      line_items_attributes: [:id, :product_id]
    )
  end
end
