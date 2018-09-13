class ProductsController < ApplicationController
	before_action :authenticate_admin!, :except => :shop
	before_action :set_product, only: [:edit, :update]

	def shop
		@products = Product.where(:live => true).order(:created_at => "desc")
		render :layout => "shop"
	end

	def dashboard

	end

	def index
		@object_name = "Product"
		@search_field = :name_cont
		@q = Product.ransack(params[:q])
		@products = @q.result.order(:created_at => "desc").page params[:page]
	end

	def new
		@product = Product.new
		@product.price_currency = :usd
	end

	def create
	  @product = Product.new(product_params)
	  respond_to do |format|
	    if @product.save
	      format.html { redirect_to products_path }
	      format.json { render :show, status: :created, location: @product }
	    else
	      format.html { render "new" }
	      format.json { render json: @product.errors, status: :unprocessable_entity }
	    end
	  end
	end

	def update
	  respond_to do |format|
	    if @product.update(product_params)
	      format.html { redirect_to products_path }
	      format.json { render :show, status: :ok, location: @product }
	    else
	      format.html { render :index }
	      format.json { render json: @product.errors, status: :unprocessable_entity }
	    end
	  end
	end

	private

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def product_params
	    params.require(:product).permit(:name, :description, :downloadtype, :price, :price_currency, :price_cents, :live, :file)
	  end

	  # Use callbacks to share common setup or constraints between actions.
	  def set_product
	    @product = Product.find(params[:id])
	  end

end
