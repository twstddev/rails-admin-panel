module EditorForbidden
	extend ActiveSupport::Concern

	included do
		append_before_action :check_editor_permission
	end

	private
		def check_editor_permission
			redirect_to admin_pages_path unless can? :manage, MenuItem
		end
end
