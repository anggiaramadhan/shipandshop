class LineItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :product
  belongs_to :cart
end
