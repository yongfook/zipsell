class AddSlugColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :slug, :string
  end
end
