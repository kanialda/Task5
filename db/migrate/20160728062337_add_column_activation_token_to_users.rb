class AddColumnActivationTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activation_token, :string
  end
end
