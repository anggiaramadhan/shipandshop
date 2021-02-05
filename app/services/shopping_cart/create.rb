module ShoppingCart
  class Create

    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def call
      response
    end

    private

    def cart
      @cart ||= Cart.create(params)
    end

    def response
      {
        status: :ok,
        data: line_items_serializer(cart),
        message: 'cart has been creeted'
      }
    end

    def line_items_serializer(data)
      data.line_items.map do |item|
        {
          id: item.product_variant.id.to_s,
          name: item.product_variant.product.name,
          description: item.product_variant.product.description
        }
      end
    end
  end
end