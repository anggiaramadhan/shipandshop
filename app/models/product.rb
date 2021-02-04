require 'elasticsearch/model'

class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :store
  embeds_many :variants
  has_many :line_items

  field :name, type: String
  field :rating, type: Integer
  field :description, type: String

  # Elasticsearch configuration
  index_name "product-#{Rails.env}"
  document_type "product"
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :id
      indexes :name, analyzer: 'english', index_options: 'offsets'
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:id, :name])
  end

  # callback for manage elasticsearch document
  after_create do
    __elasticsearch__.index_document
  end

  after_update do
    __elasticsearch__.update_document
  end

  after_destroy do
    __elasticsearch__.delete_document
  end
end
