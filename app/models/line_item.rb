class LineItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :product_variant
  belongs_to :cart
  belongs_to :store
end
