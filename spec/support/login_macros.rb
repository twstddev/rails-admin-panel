
module LoginMacros
	def login_admin
		before :each do
			user = User.create(
				username: "admin",
				email: "admin@admin.com",
				password: "password1234"
			)

			user.role = UserRole.create(
				title: "admin"
			)
			sign_in user
		end
	end

	def login_editor
		before :each do
			user = User.create(
				username: "editor",
				email: "editor@admin.com",
				password: "password1234"
			)

			user.role = UserRole.create(
				title: "editor"
			)
			sign_in user
		end
	end
end
