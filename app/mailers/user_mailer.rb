class UserMailer < ActionMailer::Base
  def reset_password_email(target_email, forgot_password_token)
    @forgot_password_token = forgot_password_token
    mail(:to => target_email,
    :from => "develror08@gmail.com",
    :subject => "[Training - Rails 4]") do |format|
      format.html { render 'reset_password_email'}
    end
  end
end
