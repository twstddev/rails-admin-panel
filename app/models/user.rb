class User
	include Mongoid::Document
	include Mongoid::Timestamps

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable,
		:rememberable, :trackable, :validatable

	## Database authenticatable
	field :username, type: String
	field :email,              type: String, default: ""
	field :encrypted_password, type: String, default: ""

	## Recoverable
	field :reset_password_token,   type: String
	field :reset_password_sent_at, type: Time

	## Rememberable
	field :remember_created_at, type: Time

	## Trackable
	field :sign_in_count,      type: Integer, default: 0
	field :current_sign_in_at, type: Time
	field :last_sign_in_at,    type: Time
	field :current_sign_in_ip, type: String
	field :last_sign_in_ip,    type: String

	validates :username, presence: true
	validates :username, uniqueness: true
	validates :email, presence: true
	validates :role, presence: true
	validates :password, confirmation: true
	#validates :password_confirmation, presence: true

	embeds_one :profile, class_name: "UserProfile"
	belongs_to :role, class_name: "UserRole"

	## Confirmable
	# field :confirmation_token,   type: String
	# field :confirmed_at,         type: Time
	# field :confirmation_sent_at, type: Time
	# field :unconfirmed_email,    type: String # Only if using reconfirmable

	## Lockable
	# field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,    type: String # Only if unlock strategy is :email or :both
	# field :locked_at,       type: Time

	##
	# @brief Checks if the user is included into the
	# given role
	#
	# @param symbol role is the role to check against
	# @return boolean comparison result
	##
	def has_role?( role )
		return self.role.title.to_sym == role if self.role
		false
	end
end
