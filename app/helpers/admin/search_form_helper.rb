module Admin::SearchFormHelper
	##
	# @brief Returns a simple search form
	# for index pages.
	##
	def search_form( path )
		search_button = button_to "", class: "btn btn-primary", type: "submit" do
			content_tag :i, "", class: "glyphicon glyphicon-search"
		end

		form_tag path, method: "get", class: "search-form input-group pull-right" do
			content = text_field_tag :search, params[ :search ], placeholder: "Search...", class: "search-input form-control"

			 content << content_tag( :span, search_button, class: "input-group-btn" )
		end
	end
end
