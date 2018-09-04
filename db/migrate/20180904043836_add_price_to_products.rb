class AddPriceToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_monetize :products, :price
  end
end
