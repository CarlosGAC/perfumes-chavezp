class AddAddressDataToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :colony, :string
    add_column :clients, :external_address_num, :integer
    add_column :clients, :internal_address_num, :integer
    add_column :clients, :zipcode, :integer
    add_column :clients, :city, :string
    add_column :clients, :state, :string
  end
end
