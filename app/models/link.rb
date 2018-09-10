class Link < ApplicationRecord
	belongs_to :payment
	acts_as_hashids length: 20

end
