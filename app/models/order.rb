class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  NEW = 'new'.freeze
  SHIPPING = 'shipping'.freeze
  CONFIRMED = 'confirmed'.freeze

  field :status, type: String, default: NEW

  belongs_to :user
  belongs_to :product
end
