
module LoginMacros
	def login_admin
		before :each do
			@request.env["devise.mapping"] = Devise.mappings[:user]

			user = User.create(
				username: "admin",
				email: "admin@admin.com",
				password: "password1234"
			)

			user.role = UserRole.create(
				title: "admin"
			)

			user.save

			sign_in user
		end
	end

	def login_editor
		before :each do
			@request.env["devise.mapping"] = Devise.mappings[:user]

			user = User.create(
				username: "editor",
				email: "editor@admin.com",
				password: "password1234"
			)

			user.role = UserRole.create(
				title: "editor"
			)

			user.save

			sign_in user
		end
	end
end
