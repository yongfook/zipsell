class CreateUniqueNumbersGenerators < ActiveRecord::Migration[5.2]
  def change
    create_table :unique_numbers_generators do |t|
      t.string :type
      t.string :name, index: true
      t.string :format
      t.text :settings
      t.datetime :last_generated_at
      t.timestamps
    end
  end
end