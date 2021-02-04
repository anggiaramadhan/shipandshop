class ProductsController < ApplicationController
  def index
    index = Catalog::Index.new(index_params).call
    render json: index
  end

  private

  def index_params
    params.permit(:store_id, :name, :limit)
  end
end
