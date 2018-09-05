class PaymentsController < ApplicationController

	def create
    @product = Product.find(params[:payment][:product_id])
    @payment = @product.payments.new(:stripe_params => params)
    respond_to do |format|
      if @payment.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :index }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

end
