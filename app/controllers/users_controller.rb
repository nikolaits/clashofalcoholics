class UsersController < ApplicationController
	#def login
		# Find user by email and password
		# If user found initialize session
		# session[:authenticated] = true
		# session[:user_id] = @user.id
		# describe POST /users/login

	#end

	#def logout
		# Clear session
	#end
	
	# Process login form
	def login
		@error = false;
		@user = User.where(email: params[:email], crypted_password: User.encrypted_password(params[:password])).first
		if @user
			session[:user_id] = @user.id
		else	
			@error =true
		end
	end
	# Destroy user session and redirect to login page
	def logout
		reset_session
		
	end
end
