require "formtastic"

##
# @brief This class add functionality to formtastic
# that allows to create and remove dynamic fields.
##
module HasManyMeta
	##
	# @brief Creates nested set of fields for custom fields.
	#
	# @param string association is the name of the 
	# nested fields fieldset
	##
	def has_many_meta( association, options = {}, &block )
		values = object[ association ] || {}
		
		# prepopulate with existing data
		form_output = "".html_safe
		fields_output = "".html_safe

		values.each_with_index do |( key, value ), index|
			fields_output << build_fields_group( association, index, OpenStruct.new( value ), &block )
		end

		form_output << template.content_tag( :div, fields_output, class: "nested-meta-fields", data: { index: values.size } )
		form_output << create_add_fields_button( association, &block )

		form_output
	end

	private
		##
		# @brief Creates an add button that creates
		# fieldset with nested fields.
		##
		def create_add_fields_button( association, &block )
			button_text = "Add #{association.to_s.singularize}"
			placeholder = "NEW_#{association.to_s.upcase.split( " " ).join( "_" )}_RECORD"

			new_form = build_fields_group( association, placeholder, OpenStruct.new, &block )

			template.link_to button_text, "#", class: "btn btn-primary has-many-meta", data: { html: CGI.escapeHTML( new_form ).html_safe, placeholder: placeholder }
		end

		##
		# @brief Outputs nested form HTML.
		##
		def build_fields_group( association, placeholder, object, &block )
			content = semantic_fields_for association do |assoc|
				assoc.semantic_fields_for placeholder.to_s, object do |nested|
					block.call nested
				end
			end

			content << create_remove_button

			content = template.content_tag( :fieldset, content, class: "inputs has-many-fields well")

			content
		end

		##
		# @brief Creates a remove button that is used to
		# delete the current fieldset.
		##
		def create_remove_button
			template.link_to( "Remove", "#", class: "btn btn-danger has-many-remove" )
		end
end

Formtastic::FormBuilder.send :include, HasManyMeta
