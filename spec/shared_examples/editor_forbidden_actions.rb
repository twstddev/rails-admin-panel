shared_examples "a forbidden action" do |actions|
	actions.each do |action|
		specify "denies access to" do
			send( action[ :verb ], action[ :action ], action[ :params ] )
			expect( response ).to redirect_to( index_path )
		end
	end

end
