class AddIntroToProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :intro, :text
  end
end
