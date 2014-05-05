require 'spec_helper'
require "support/login_macros"
require "shared_examples/editor_forbidden_actions"

RSpec.configure do |config|
	config.include Devise::TestHelpers, type: :controller
	config.extend LoginMacros, type: :controller
end

describe Admin::UsersController do
	context "as editor" do
		login_editor

		it_behaves_like "a forbidden action", [
			{
				verb: :get,
				action: :index,
				params: {}
			}
		] do
			let( :index_path ) { admin_pages_path }
		end
	end
end
