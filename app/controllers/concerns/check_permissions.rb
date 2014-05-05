module CheckPermissions
	extend ActiveSupport::Concern

	included do
		append_before_action :check_permission
	end

	private
		def check_permission
			redirect_to admin_pages_path unless can? :manage, self.class
		end
end
