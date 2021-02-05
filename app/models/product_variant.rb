class ProductVariant
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :product
  has_many :line_items

  field :color, type: String
  field :size, type: String
end
