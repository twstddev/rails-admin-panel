class Ability
	include CanCan::Ability

	def initialize( user )
		@user = user || User.new

		if @user.role
			send( @user.role.title.to_sym )
		end
	end

	def admin
		can :manage, :all
	end

	def editor
		can :manage, Page
	end
end
