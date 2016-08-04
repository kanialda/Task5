class UsersController < ApplicationController
 require 'rest-client'
 require 'json'
 
  username = "kanialda" # needed to access the APi
  password = "kanialisda123" # needed to access the APi
  API_BASE_URL = 'http://kanialda:kanialisda123@0.0.0.0:3000/api/v1/bycycles'# base url of the API
  
  def index
    
    RestClient.get(API_BASE_URL )
    # RestClient.get 'http://kanialda:kanialisda123@0.0.0.0:3000/api/v1/bycycles', {:accept => :json}
    # JSON.parse(response)

  end

  def new
    @user = User.new
  end

  def create
    
    @user = User.new(params_user)
    if @user.save
      begin
        ConfirmationMailer.confirm_email("#{@user.email}", @user.activation_token).deliver
      rescue
        flash[:notice] = "activation instruction fails send to your email"
      end
      flash[:notice] = "activation instruction has send to #{@user.email}"
      redirect_to root_url
    else
      flash[:error] = "data not valid"
      render "new"
    end
  end

  def edit
  end

  private

  def params_user
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
