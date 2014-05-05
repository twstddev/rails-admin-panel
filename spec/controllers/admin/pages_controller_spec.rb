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
		get :show, @page

		expect( response ).to redirect_to( edit_admin_page_path )
	end

	it "sets a new record for new action" do
		get :new

		expect( assigns( :page ) ).to be_new_record
	end

	describe "POST 'create'" do
		before :each do
			@new_page = Page.new(
				title: "Contact"
			)

			post :create, @new_page
		end

		it "creates a new record" do
			expect( @new_page ).to be_persisted
		end

		it "sets a success flash message" do
			expect( falsh[ :success ] ).to exist
		end

		it "redirects to edit page" do
			expect( response ).to redirect_to( edit_admin_page_path )
		end
	end

	it "sets an existing page to edit template" do
		get :edit, @page

		expect( assigns( :page ).title ).to eq( @page.title )
	end

	describe "PATCH 'update'" do
		before :each do
			let( :another_title ) { "my new title" }
			@page.title = another_title

			patch :update, @page
		end

		it "updates a page" do
			expect( @page ).to be_changed
		end

		it "sets a success flash message" do
			expect( flash[ :success ] ).to exist
		end

		it "redirects to edit page" do
			expect( response ).to redirect_to( edit_admin_page_path )
		end
	end

	describe "DELETE 'destroy'" do
		before :each do
			delete :destroy, @page
		end

		it "deletes a page" do
			expect( @page ).to be_destroyed
		end

		it "sets success message" do
			expect( flash[ :success ] ).to exist
		end

		it "redirect to index page" do
			expect( response ).to redirect_to( admin_pages_path )
		end
	end
end
