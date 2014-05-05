require 'spec_helper'
require "support/login_macros"

RSpec.configure do |config|
	config.include Devise::TestHelpers, type: :controller
	config.extend LoginMacros, type: :controller
end

describe Admin::PagesController do
	login_admin

	before :each do
		@page = Page.create(
			title: "Home",
			template: "home"
		)
	end

	it "sets a list of pages" do
		Page.create(
			title: "About",
			template: ""
		)

		get :index

		expect( assigns( :pages ).count ).to eq( 2 )
	end

	it "redirects to page edit on show" do
		get :show, id: @page.id

		expect( response ).to redirect_to( edit_admin_page_path( @page ) )
	end

	it "sets a new record for new action" do
		get :new

		expect( assigns( :page ) ).to be_new_record
	end

	describe "POST 'create'" do
		before :each do
			post :create, page: { title: "Contact" }
		end

		it "creates a new record" do
			expect( assigns( :page ) ).to be_persisted
		end

		it "sets a success flash message" do
			expect( flash[ :success ] ).not_to be_blank
		end

		it "redirects to edit page" do
			expect( response ).to redirect_to( edit_admin_page_path( assigns( :page ) ) )
		end
	end

	it "sets an existing page to edit template" do
		get :edit, id: @page.id

		expect( assigns( :page ) ).to eq( @page )
	end

	describe "PATCH 'update'" do
		before :each do
			patch :update, id: @page.id, page: { title: "Another title" }
		end

		it "updates a page" do
			expect( assigns( :page ) ).to be_persisted
		end

		it "sets a success flash message" do
			expect( flash[ :success ] ).not_to be_blank
		end
	end

	describe "DELETE 'destroy'" do
		before :each do
			delete :destroy, id: @page.id
		end

		it "deletes a page" do
			expect( assigns( :page ) ).to be_destroyed
		end

		it "sets success message" do
			expect( flash[ :success ] ).not_to be_blank
		end

		it "redirect to index page" do
			expect( response ).to redirect_to( admin_pages_path )
		end
	end
end
