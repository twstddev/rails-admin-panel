require "spec_helper"
require "cancan/matchers"

describe Ability do
	subject( :ability ){ Ability.new( user ) }
	let( :user ){ nil }

	context "allows admin to edit menu items" do
		let( :user ) do
			user = User.new(
				username: "admin",
				email: "admin@admin.com",
				password: "amdin123456"
			)

			user.role = UserRole.create(
				title: "admin"
			)

			user.save
			user
		end

		it { should be_able_to( :manage, MenuItem ) }
	end

	context "allows editor to edit pages, but not menu items" do
		let( :user ) do
			user = User.new(
				username: "editor",
				email: "editor@admin.com",
				password: "editor1234"
			)

			user.role = UserRole.create(
				title: "editor"
			)

			user.save
			user
		end

		it { should be_able_to( :manage, Page ) }
		it { should_not be_able_to( :manage, MenuItem ) }
	end
end
