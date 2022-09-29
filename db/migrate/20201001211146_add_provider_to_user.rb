class AddProviderToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
  end
end
