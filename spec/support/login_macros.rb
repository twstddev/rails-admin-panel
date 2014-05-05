
module LoginMacros
	def login_admin
		before :each do
			sign_in User.create(
				username: "admin",
				email: "admin@admin.com",
				password: "password1234"
			)
		end
	end
end
