class AddSkuToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :sku, :string
  end
end
