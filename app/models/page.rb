class Page
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :title, type: String
  field :slug, type: String
  field :body, type: String
  field :template, type: String
  field :properties, type: Hash
end
