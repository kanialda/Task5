class AddForgotTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :forgot_password_token, :string
  end
end
