class OrdersController < ApplicationController
  def create
  end

  private

  def order_params
    params.permit(
      :id,
      :user_id,
      :cart_id,
      order_items_attributes: %i[id store_id product_variant_id]
    )
  end
end