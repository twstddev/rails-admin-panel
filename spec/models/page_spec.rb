require 'spec_helper'

describe Page do
	let( :custom_properties ) do
		{
			"meta_field" => "meta_value"
		}
	end

	before :each do
		Page.stub( :templates ).and_return( {
			"Home" => "home"
		} )

		@page = Page.new( 
			title: "Home",
			template: "home",
			properties: custom_properties
		)
	end

	it "requires title" do
		@page.title = ""
		@page.save

		expect( @page ).to have( 1 ).error_on( :title )
	end

	it "has unique slug" do
		another_page = Page.create( 
			title: "Home",
		)

		@page.save

		expect( another_page.slugs ).to include( "home" )
		expect( @page.slugs ).not_to include( "home" )
	end

	it "generates slug from title" do
		@page.title = "Another title"
		@page.save

		expect( @page.slug ).to eq( "another-title" )
	end

	it "saves properties" do
		@page.save

		expect( @page.properties ).to eq( custom_properties )
	end

	it "sets default value to properties" do
		another_page = Page.create(
			title: "About",
			slug: "about"
		)

		expect( another_page.properties ).to be_a( Hash )
		expect( another_page.properties ).to eq( {} )
	end

	it "validates template existence" do
		@page.template = "fake"
		@page.save

		expect( @page ).to have( 1 ).error_on( :template )
	end

	it "returns page by slug" do
		@page.save
		new_page = Page.find "home"

		expect( new_page.title ).to eq( "Home" )
	end
end
