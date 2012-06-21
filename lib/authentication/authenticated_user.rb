# -*- encoding : utf-8 -*-
module Authentication
	module AuthenticatedUser
		#
		def self.included(base)
			base.class_eval do
				helper_method(:authenticated_user)
			end
		end

		#
		def authenticated_user
			if @authenticated_user.nil?
				@authenticated_user = User.find(session[:user_id])
			end
			@authenticated_user
		end
	end
end
