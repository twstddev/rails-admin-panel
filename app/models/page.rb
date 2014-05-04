class Page
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic

	field :title, type: String
	field :slug, type: String
	field :body, type: String
	field :template, type: String
	field :properties, type: Hash, default: {}

	validates :title, presence: true
	validate :validate_template

	##
	# @brief Returns a map of supported templates, that
	# provide sets of custom fields.
	#
	# @return Hash a list of predefined templates
	##
	def self.templates
		{
			"Home" => "home"
		}
	end

	private
		##
		# @brief Makes sure that user doesn't pass forbidden
		# template.
		##
		def validate_template
			unless template.blank? or self.class.templates.has_value? template
				errors.add( :template, "is not on the templates list" )
			end
		end

end
