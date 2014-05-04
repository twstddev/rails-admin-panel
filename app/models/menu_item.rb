class MenuItem
  include Mongoid::Document
  field :title, type: String
  field :url, type: String

  validates :title, presence: true
  validates :url, presence: true
end
