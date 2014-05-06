module Admin::CurrentPageHelper
	##
	# @brief Checks whether a path is the current.
	##
	def is_current_page( path )
		if path == controller.controller_name
			return "active"
		end
		""
	end
end
