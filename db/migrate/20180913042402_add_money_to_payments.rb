class AddMoneyToPayments < ActiveRecord::Migration[5.2]
  def change
  	add_monetize :payments, :amount # Rails 4x and above
  end
end
