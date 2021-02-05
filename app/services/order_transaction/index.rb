module OrderTransaction
  class Index
    attr_accessor :user_id

    def initialize(params)
      @user_id = params[:user_id]
    end

    def call
      response
    end

    private

    def user
      @user ||= User.find(user_id)
    end

    def fetch_user_orders
      user.orders.map do |x|
        {
          id: x.id.to_s,
          products: x.order_items do |y|
            {
              id: y.product_variant.id.to_s,
              product_name: y.product_variant.product.name,
              product_color: y.product_variant.color,
              product_size: y.product_variant.size
            }
          end
        }
      end
    end

    def response
      {
        status: :ok,
        data: fetch_user_orders
      }
    end
  end
end