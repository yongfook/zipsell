class AddCustomerForeignKeyToPayments < ActiveRecord::Migration[5.2]
  def change
  	add_reference :payments, :customer, index: true
  end
end
