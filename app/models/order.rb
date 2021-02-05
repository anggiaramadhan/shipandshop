class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  NEW = 'new'.freeze
  SHIPPING = 'shipping'.freeze
  CONFIRMED = 'confirmed'.freeze

  field :status, type: String, default: NEW

  belongs_to :user
  has_many :order_items
  accepts_nested_attributes_for :order_items
end
