class Admin::MenuItemsController < Admin::AdminController
	include CheckPermissions

	def index
		@menu_items = MenuItem.where( ancestry: nil ).order( :position.asc )
	end

	def show
		menu_item = MenuItem.find( params[ :id ] )

		redirect_to admin_menu_items_path
	end

	def new
		@menu_item = MenuItem.new
	end

	def create
		@menu_item = MenuItem.new( permit_params )

		if @menu_item.save
			flash[ :success ] = "A new menu item has been created"
			redirect_to admin_menu_items_path
		else
			render :new
		end
	end

	def edit
		@menu_item = MenuItem.find( params[ :id ] )
	end

	def update
		@menu_item = MenuItem.find( params[ :id ] )
		
		if @menu_item.update_attributes( permit_params )
			flash[ :success ] = "A menu item has been updated"
			redirect_to admin_menu_items_path
		else
			redirect_to
		end
	end

	def destroy
		@menu_item = MenuItem.find( params[ :id ] )	
		@menu_item.destroy

		flash[ :success ] = "A menu item has been deleted"
		redirect_to admin_menu_items_path
	end

	def sort
		if params[ :items ]
			save_sorted_items params[ :items ]
		end

		render nothing: true, status: 200
	end

	private
		def permit_params
			params.require( :menu_item ).permit( :title, :url, :parent )
		end

		##
		# @brief Goes through the list of items and 
		# saves them with assigned positions.
		##
		def save_sorted_items( items, parent = nil )
			items.each do |index, object|
				if object[ :id ]
					current_id = object[ :id ]

					current_menu_item = MenuItem.find( current_id )
					current_menu_item.parent_id = parent
					current_menu_item.position = index
					current_menu_item.save

					if object[ :children ]
						save_sorted_items object[ :children ], current_id
					end
				end
			end
		end
end
