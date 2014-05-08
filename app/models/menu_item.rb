class MenuItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Ancestry

  has_ancestry

  field :title, type: String
  field :url, type: String
  field :position, type: Integer, default: 0

  validates :title, presence: true
  validates :url, presence: true
end
