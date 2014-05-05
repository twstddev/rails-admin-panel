class Api::MenuItemsController < Api::JsonController
	def index
		@menu_items = MenuItem.all
	end
end
