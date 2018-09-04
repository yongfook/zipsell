class ProductsController < ApplicationController
	before_action :authenticate_admin!

	def dashboard

	end

	def new
		@product = Product.new
	end

	def create
	  @product = Product.new(product_params)
	  respond_to do |format|
	    if @product.save
	      format.html { redirect_to dashboard_path }
	      format.json { render :show, status: :created, location: @product }
	    else
	      format.html { render "new" }
	      format.json { render json: @product.errors, status: :unprocessable_entity }
	    end
	  end
	end

	private

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def product_params
	    params.require(:product).permit(:name, :description, :type)
	  end

end
