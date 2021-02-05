module OrderTransaction
  class Create
    attr_accessor :params, :cart_id, :user_id, :order_items_attrs

    def initialize(params)
      @params = params
      @cart_id = params[:cart_id]
      @user_id = params[:user_id]
      @order_items_attrs = params[:order_items_attributes]
    end

    def call
      find_cart_by_id
      delete_product_from_cart
      response
    end

    private

    def user
      @user ||= User.find(user_id)
    end

    def order
      @order ||= Order.create(params)
    end

    def cart
      @cart ||= Cart.find(cart_id)
    end

    def product_variant_ids
      order_items_attrs.pluck(:product_variant_id)
    end

    def delete_product_from_cart
      cart.line_items.where(:product_variant_id.in => product_variant_ids)
    end

    def response
      {
        status: :ok,
        data: order_items_serializer(order),
        message: 'order has been creeted'
      }
    end

    def order_items_serializer(data)
      data.order_items.map do |item|
        {
          id: item.product_variant.id.to_s,
          name: item.product_variant.product.name,
          description: item.product_variant.product.description
        }
      end
    end
  end
end