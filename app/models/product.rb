class Product < ApplicationRecord
	validates_presence_of :name
	validates_presence_of :description
	validates_uniqueness_of :sku
	validates :price_cents, numericality: { greater_than: 0 }
	monetize :price_cents
	has_unique_number :sku, generator: :products, type: :sequential, format: 'P%04i', start_value: 1
	has_many :payments
	has_attached_file :file
	validates_attachment_presence :file
	validates_attachment_file_name :file, :matches => [/zip\Z/, /pdf\Z/]

end
