require 'rails_helper'
RSpec.describe UsersController, type: :controller do
	describe 'POST /users/login' do
		it 'assigns an error if user not found with credentials' do
			post :login, { email: 'test@example.com', password: '1234', format:'json' }

			expect(assigns(:error)).to eq(true)
		end

		it 'creates a session if user is found' do
			# Create dummy user
			@user  = User.create(email:'test@example.com', crypted_password: User.encrypted_password('1234'))
			post :login, {email:@user.email, password:'1234', format: 'json'} # ok credentials

			expect(session[:user_id]).to eq(@user.id) # id of precreated user
		end
	end
	
end