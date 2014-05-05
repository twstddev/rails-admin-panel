class Admin::MenuItemsController < ApplicationController
	append_before_action :check_permission

	def index
		@menu_items = MenuItem.all
	end

	def show
		menu_item = MenuItem.find( params[ :id ] )

		redirect_to edit_admin_menu_item_path( menu_item )
	end

	def new
		@menu_item = MenuItem.new
	end

	def create
		@menu_item = MenuItem.new( permit_params )

		if @menu_item.save
			flash[ :success ] = "A new menu item has been created"
			redirect_to edit_admin_menu_item_path( @menu_item )
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
		end
		render :edit
	end

	def destroy
		@menu_item = MenuItem.find( params[ :id ] )	
		@menu_item.destroy

		flash[ :success ] = "A menu item has been deleted"
		redirect_to admin_menu_items_path
	end

	private
		def permit_params
			params.require( :menu_item ).permit( :title, :url, :parent )
		end

		def check_permission
			redirect_to admin_pages_path unless can? :manage, MenuItem
		end
end
