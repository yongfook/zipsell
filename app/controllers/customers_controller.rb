class CustomersController < ApplicationController

	def index
		@customers = Customer.all.order(:created_at => "desc").page params[:page]
	end

end
