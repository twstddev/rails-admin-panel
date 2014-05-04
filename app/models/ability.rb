class Ability
	include CanCan::Ability

	def initialize( user )
		@user = user || User.new

		if @user.role
			send( @user.role )
		end
	end

	def admin
		can :manage, :all
	end

	def editor
		can :manage, Page
	end
end
