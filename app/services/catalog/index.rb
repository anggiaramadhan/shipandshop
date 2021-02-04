module Catalog
  class Index
    attr_accessor :params, :name, :store_id, :limit

    def initialize(params)
      @params = params
      @name = params[:name]
      @store_id = params[:store_id]
      @limit = params[:limit]
    end

    def call
      filter_by_name if params.key?(:name)
      filter_by_store if params.key?(:store_id)

      response
    end

    private

    def products
      @products ||= Product.all.limit(limit)
    end

    def filter_by_name
      response = Product.search name
      @products = response.records.limit(limit)
    end

    def filter_by_store
      @products = Product.where(store_id: store_id).limit(limit)
    end

    def response
      {
        status: :ok,
        data: product_serializer(products)
      }
    end

    def product_serializer(data)
      data.map do |x|
        {
          id: x.id.to_s,
          name: x.name,
          rating: x.rating,
          description: x.description,
          store: store_serializer(x.store),
          variants: variant_serializer(x.variants)
        }
      end
    end

    def variant_serializer(data)
      data.map do |x|
        {
          id: x.id.to_s,
          color: x.color,
          size: x.size
        }
      end
    end

    def store_serializer(data)
      {
        id: data.id.to_s,
        name: data.name
      }
    end
  end
end