class UserRole
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :users
end
