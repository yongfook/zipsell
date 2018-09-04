class AddToggleToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :live, :boolean, :default => false
  end
end
