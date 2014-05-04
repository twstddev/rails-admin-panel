require 'spec_helper'

describe MenuItem do
	before :each do
		@menu_item = MenuItem.new(
			title: "Home",
			url: "home"
		)
	end

	it "requires title" do
		@menu_item.title = ""

		expect( @menu_item ).to have( 1 ).error_on( :title )
	end

	it "requires url" do
		@menu_item.url = ""
		expect( @menu_item ).to have( 1 ).error_on( :url )
	end

	it "can have children" do
		@menu_item.children.create(
			title: "About",
			url: "about"
		)

		expect( @menu_item.children.first.parent_id ).to eq( @menu_item.id )
	end
end
