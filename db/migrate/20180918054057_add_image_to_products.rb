class AddImageToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_attachment :products, :image
  end
end
