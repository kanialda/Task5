class SessionsController < ApplicationController
  def new
    render "login"
  end
  
  def create
   username = params[:username]
   password = params[:password]
   
   user = User.find_by(username: username).try(:authenticate, password)
   if user
   session[:user] = user.id
   flash[:notice] = "Welcome #{user.username}"
   redirect_to root_url
   else
   params[:username]
   flash[:error] = "Your data not valid"
   render "new"
   end
  end
  
  def logout
   session[:user] = nil
   flash[:notice] = "Logout successful"
   redirect_to root_url
  end
  
end