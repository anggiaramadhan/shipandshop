module ShoppingCart
  class Update
    attr_accessor :id, :user_id, :line_items_attrs

    def initialize(params)
      @id = params[:id]
      @user_id = params[:user_id]
      @line_items_attrs = params[:line_items_attributes]
    end

    def call
      update_cart
      response
    end

    private

    def cart
      @cart ||= Cart.find(id)
    end

    def product_ids
      line_items_attrs.pluck(:product_id)
    end

    def line_items
      @line_items ||= cart.line_items.where(:product_id.in => product_ids)
    end

    def update_cart
      line_items.destroy_all
    end

    def response
      {
        status: :ok,
        message: 'product has been removed from cart'
      }
    end
  end
end