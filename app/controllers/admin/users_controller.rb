class Admin::UsersController < Admin::AdminController
	include CheckPermissions

	def index
		@users = User.all.order_by( :created_at.asc )
	end

	def show
		user = User.find( params[ :id ] )
		redirect_to edit_admin_user_path( user )
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new( permit_params )

		if @user.save
			flash[ :success ] = "A new user has been created"
			redirect_to admin_users_path
		else
			render :new
		end
	end
	
	def edit
		@user = User.find( params[ :id ] )
	end

	def update
		@user = User.find( params[ :id ] )
		if @user.update_attributes( permit_params )
			flash[ :success ] = "A user has been updated"
		end

		redner :edit
	end

	def destroy
		@user = User.find( params[ :id ] )
		@user.destroy

		flash[ :success ] = "A user has been deleted"
		redirect_to admin_users_page
	end

	private
		def permit_params
			params.require( :user ).permit( :username, :email, :first_name, :last_name, :password, :password_confirmation )
		end
end
