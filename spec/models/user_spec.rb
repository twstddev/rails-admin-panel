require 'spec_helper'

describe User do
	before :each do
		@user = User.new(
			username: "admin",
			email: "admin@admin.com",
			password: "admin"
		)
	end

	it "requires username presence" do
		@user.username = ""
		@user.save

		expect( @user ).to have( 1 ).error_on( :username )
	end

	it "requires username uniqueness" do
		User.create(
			username: "admin",
			email: "another@admin.com",
			password: "admin123456"
		)

		@user.save

		expect( @user ).to have( 1 ).error_on( :username )
	end

	it "requries email presence" do
		@user.email = ""

		expect( @user ).not_to have( 0 ).error_on( :email )
	end

	it "responds to role" do
		role = UserRole.create( 
			title: "admin"
		)

		@user.role = role
		@user.save

		expect( @user.has_role?( :admin ) ).to eq( true )
	end
end
