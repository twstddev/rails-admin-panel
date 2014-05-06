module Admin::CurrentPageHelper
	##
	# @brief Checks whether a path is the current.
	##
	def is_current_page( path )
		if current_page? path
			return "active"
		end
		""
	end
end
