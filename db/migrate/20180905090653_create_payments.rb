class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
    	t.text :stripe_params
    	t.text :stripe_response
      t.timestamps
    end
  end
end
