class Variant
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :product

  field :color, type: String
  field :size, type: String 
end
