class Customer < ApplicationRecord
	has_many :payments
	acts_as_hashids length: 10

end
