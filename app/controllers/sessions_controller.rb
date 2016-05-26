class SessionsController < ApplicationController

  def new
  end

  def create
  	# { session: { email: "abc@abc.com", password: "123" } }
  	# params[:session] = { password: "foobar", email: "user@example.com" }
  	# params[:session][:email] = email
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	flash[:success] = 'Successfully logged in!'
    	log_in user
    	redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end