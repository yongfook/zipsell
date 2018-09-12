class CustomersController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		@customers = Customer.all.order(:created_at => "desc").page params[:page]
	end

	def show
		@customer = Customer.find(params[:id])
	end

end
