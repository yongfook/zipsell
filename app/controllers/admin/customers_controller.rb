class Admin::CustomersController < Admin::BaseController

	def index
		@object_name = "Customer"
		@search_field = :email_cont
		@q = Customer.ransack(params[:q])
		@customers = @q.result.order(:created_at => "desc").page params[:page]
	end

	def show
		@customer = Customer.find(params[:id])
	end

end
