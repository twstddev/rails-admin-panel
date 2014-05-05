require 'spec_helper'
require "support/login_macros"
require "shared_examples/editor_forbidden_actions"

RSpec.configure do |config|
	config.include Devise::TestHelpers, type: :controller
	config.extend LoginMacros, type: :controller
end

describe Admin::MenuItemsController do
	context "as admin" do
		login_admin

		before :each do
			@menu_item = MenuItem.create(
				title: "Home",
				url: "home"
			)
		end

		it "sets a list of menu items" do
			get :index

			expect( assigns( :menu_items ).count ).to eq( 1 )
		end

		it "redirects to menu item edit on show" do
			get :show, id: @menu_item.id

			expect( response ).to redirect_to( edit_admin_menu_item_path( @menu_item ) )
		end

		it "sets a new record for new action" do
			get :new

			expect( assigns( :menu_item ) ).to be_new_record
		end

		describe "POST 'create'" do
			before :each do
				post :create, menu_item: { title: "Contact", url: "contact" }
			end

			it "creates a new record" do
				expect( assigns( :menu_item ) ).to be_persisted
			end

			it "sets a success flash message" do
				expect( flash[ :success ] ).not_to be_blank
			end

			it "redirects to index page" do
				expect( response ).to redirect_to( admin_menu_items_path( assigns( :menu_item ) ) )
			end
		end

		it "sets an existing menu item to edit template" do
			get :edit, id: @menu_item.id

			expect( assigns( :menu_item ) ).to eq( @menu_item )
		end

		describe "PATCH 'update'" do
			before :each do
				patch :update, id: @menu_item.id, menu_item: { title: "Another title", url: "another" }
			end

			it "updates a menu item" do
				expect( assigns( :menu_item ) ).to be_persisted
			end

			it "sets a success flash message" do
				expect( flash[ :success ] ).not_to be_blank
			end
		end

		describe "DELETE 'destroy'" do
			before :each do
				delete :destroy, id: @menu_item.id
			end

			it "deletes a menu_item" do
				expect( assigns( :menu_item ) ).to be_destroyed
			end

			it "sets success message" do
				expect( flash[ :success ] ).not_to be_blank
			end

			it "redirects to index page" do
				expect( response ).to redirect_to( admin_menu_items_path )
			end
		end

	end

	context "as editor" do
		login_editor

		#@menu_item = MenuItem.create(
			#title: "Home",
			#url: "home"
		#)


		it_behaves_like "a forbidden action", [
			{
				verb: :get,
				action: :index,
				params: {}
			}
			#{
				#verb: :get, 
				#action: :show,
				#params: { id: @menu_item.id }
			#}
			#{
				#verb: :get,
				#action: :new,
				#params: {} 
			#},
			#{
				#verb: :post,
				#action: :create,
				#params: { menu_item: { title: "About", url: "about" } } 
			#},
			#{
				#verb: :get,
				#action: :edit,
				#params: { id: @menu_item.id } 
			#},
			#{
				#verb: :patch,
				#action: :update,
				#params: { id: @menu_item.id, menu_item: { title: "Home 2" } } 
			#},
			#{
				#verb: :delete,
				#action: :destroy,
				#params: { id: @menu_item.id } 
			#}
		] do
			let( :index_path ) { admin_pages_path }
		end
	end
end
