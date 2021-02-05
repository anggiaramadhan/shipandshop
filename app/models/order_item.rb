class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order
  belongs_to :product_variant
  belongs_to :store
end
