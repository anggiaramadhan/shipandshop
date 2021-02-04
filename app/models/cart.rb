class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :line_items
  accepts_nested_attributes_for :line_items

  field :status, default: false
end
