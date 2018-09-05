class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :products, :type, :downloadtype
  end
end
