class UserProfile
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String

  embedded_in :user
end
