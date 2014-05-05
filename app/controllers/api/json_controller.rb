class Api::JsonController < ApplicationController
	before_filter :check_format

	private
		def check_format
			render nothing: true, status: 406 unless params[ :format ] == "json"
		end
end
