class Admin::UsersController < Admin::AdminController
	include CheckPermissions

	def index
		@search = params[ :search ]

		unless @search.blank?
			@users = User.full_text_search( @search )
		else
			@users = User.all
		end

		@users = @users.order_by( :created_at.asc )
	end

	def show
		user = User.find( params[ :id ] )
		redirect_to edit_admin_user_path( user )
	end

	def new
		@user = User.new
		@roles = UserRole.all
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
		@roles = UserRole.all
		@user = User.find( params[ :id ] )
	end

	def update
		@user = User.find( params[ :id ] )
		if @user.update_attributes( permit_params )
			flash[ :success ] = "A user has been updated"
			redirect_to edit_admin_user_path( @user )
		else
			render :edit
		end

	end

	def destroy
		@user = User.find( params[ :id ] )

		if @user == current_user
			flash[ :danger ] = "You cannot remove yourself"
		else
			@user.destroy
			flash[ :success ] = "A user has been deleted"
		end

		redirect_to admin_users_path
	end

	private
		def permit_params
			params.require( :user ).permit( :username, :email, :password, :password_confirmation, :role_id, profile: [ :first_name, :last_name ] )
		end
end
