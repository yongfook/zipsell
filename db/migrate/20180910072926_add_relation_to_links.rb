class AddRelationToLinks < ActiveRecord::Migration[5.2]
  def change
  	add_reference :links, :payment, index: true
  end
end
