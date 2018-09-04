class Product < ApplicationRecord
	validates_presence_of :name
	validates_presence_of :description
	validates :price_cents, numericality: { greater_than: 0 }
	monetize :price_cents

end
