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
			slug: "home",
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
		Page.create( 
			title: "Another page",
			slug: "home"
		)

		@page.save

		expect( @page ).to have( 1 ).error_on( :slug )
	end

	it "generates slug from title" do
		@page.title = "Another title"
		@page.slug = ""
		@page.save

		expect( @page.slug ).to eq( "another-title" )
	end

	it "saves properties" do
		@page.save

		expect( @page.properties ).to eq( custom_properties )
	end

	it "sets default value to properties" do
		@page.properties = ""
		@page.save

		expect( @page.properties ).to be_a( Hash )
		expect( @page.properties ).to eq( {} )
	end

	it "validates template existence" do
		@page.template = "fake"
		@page.save

		expect( @page ).to have( 1 ).error_on( :template )
	end
end
