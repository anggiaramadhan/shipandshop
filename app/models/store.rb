class Store
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :products

  field :name, type: String
end
