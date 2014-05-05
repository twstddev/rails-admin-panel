class PagesController < JsonController
	def index
		@pages = Page.all.order_by( :title.asc )
	end

	def show
		@page = Page.find( params[ :id ] )

		rescue ActiveRecord::RecordNotFound => e
			render nothing: true, status: 404
	end
end
