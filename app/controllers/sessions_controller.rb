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
  
  def edit
    user = User.find_by_activation_token(params[:id])
        if user.try(:update,{activation_token: "", activation_status: "active"})
            flash[:notice] = "Your account has active"
            redirect_to root_url
        else
            flash[:notice] = "Welcome to Rails 4"
            redirect_to root_url
        end
  end

  def logout
    session[:user] = nil
    flash[:notice] = "Logout successful"
    redirect_to root_url
  end

  def reset_password;end

  def reset_password_process
    user = User.find_by_forgot_password_token(params[:id])
    if user.blank?
      flash[:error] = "Email not found"
      redirect_to root_url
    else
      reset_token = SecureRandom.urlsafe_base64
      if user.update(forgot_password_token: reset_token)
        begin
          UserMailer.reset_password_email("#{@user.email}", reset_token).deliver
        rescue
          flash[:notice] = "Reset password instruction fails send to your email"
          redirect_to reset_password_url
        end
        flash[:notice] = "Check your email for reset password instruction"
        redirect_to root_url
      else
        flash[:error] = "Fails generate token"
        redirect_to reset_password_url
      end
    end
  end

  def reset_password_edit
    user = User.find_by_forgot_password_token(params[:token])
    if user.blank?
      flash[:error] = "Token invalid"
      redirect_to root_url
    end
  end

  def reset_password_process
    user = User.find_by_forgot_password_token(params[:token])
    if user.blank?
      flash[:error] = "Token invalid"
      redirect_to root_url
    else
      new_password_hash = Bcrypt::Engine.hash_secret(params[:password],
      user.password_salt)
      if user.update(password_hash: new_password_hash)
        flash[:notice] = "Password success updated"
        redirect_to login_url
      end
    end
  end
end