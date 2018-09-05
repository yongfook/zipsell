class AddForeignKeyToPayments < ActiveRecord::Migration[5.2]
  def change
  	add_reference :payments, :product, index: true

  end
end
