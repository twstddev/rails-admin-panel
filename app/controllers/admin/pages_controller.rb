class Admin::PagesController < Admin::AdminController
	include CheckPermissions

	def index
		@search = params[ :search ]

		unless @search.blank?
			@pages = Page.full_text_search( @search )
		else
			@pages = Page.all
		end

		@pages = @pages.page( params[ :page ] ).per( 10 ).order_by( :title.asc )
	end

	def show
		page = Page.find( params[ :id ] )

		redirect_to edit_admin_page_path( page )
	end

	def new
		@page = Page.new
	end

	def create
		@page = Page.new( permit_params )

		if @page.save
			flash[ :success ] = "A new page has been created"
			redirect_to edit_admin_page_path( @page.id )
		else
			render :new
		end
	end

	def edit
		@page = Page.find( params[ :id ] )
	end

	def update
		@page = Page.find( params[ :id ] )

		if @page.update_attributes( permit_params )
			flash[ :success ] = "A page has been updated"
		end
		render :edit
	end
	
	def destroy
		@page = Page.find( params[ :id ] )
		@page.destroy

		flash[ :success ] = "A page has been deleted"
		redirect_to admin_pages_path
	end

	private

		def permit_params
			params.require( :page ).permit( :title, :slug, :body, :template ).tap do |whitelisted|
				whitelisted[ :properties ] = params[ :page ][ :properties ]
			end
		end
end
