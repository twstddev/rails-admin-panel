require 'spec_helper'

describe UserRole do
	before :each do
		@role = UserRole.new(
			title: "admin"
		)
	end

	it "requries title" do
		@role.title = ""
		@role.save

		expect( @role ).to have( 1 ).error_on( :title )
	end

	it "requires title to be unique" do
		UserRole.create(
			title: "admin"
		)

		@role.save

		expect( @role ).to have( 1 ).error_on( :title )
	end
end
