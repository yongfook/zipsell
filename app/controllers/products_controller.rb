class ProductsController < ApplicationController
	before_action :authenticate_admin!, :except => [:shop, :shop_show]
	before_action :set_product, only: [:edit, :update, :shop_show]

	def shop_show
		@q = Product.where(:live => true).ransack(params[:q])
		@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
		render :layout => "shop"
	end

	def shop
		@q = Product.where(:live => true).ransack(params[:q])
		@products = @q.result.order(:created_at => "desc").page params[:page]
		render :layout => "shop"
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
	    params.require(:product).permit(:name, :description, :downloadtype, :price, :price_currency, :price_cents, :live, :file, :intro, :image)
	  end

	  # Use callbacks to share common setup or constraints between actions.
	  def set_product
	    @product = Product.find(params[:id])
	  end

end
