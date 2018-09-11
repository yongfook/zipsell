class AddNumberToPayments < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :number, :string
  end
end
