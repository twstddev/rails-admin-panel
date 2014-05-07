class Page
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic
	include Mongoid::Timestamps
	include Mongoid::Slug
	include Mongoid::Search

	field :title, type: String
	field :body, type: String
	field :template, type: String
	field :properties, type: Hash, default: {}

	slug :title

	validates :title, presence: true
	validate :validate_template

	before_save :validate_slug

	search_in :title

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

	def slug=( custom_slug )
		@custom_slug = custom_slug
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

		##
		# @brief Checks if a custom slug has been passed.
		##
		def validate_slug
			self._slugs = [ @custom_slug ] unless @custom_slug.blank?
		end
end
