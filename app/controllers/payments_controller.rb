class PaymentsController < ApplicationController
  before_action :authenticate_admin!, :except => [:create, :success, :error]

  def dashboard
    @recent_payments = Payment.order(:created_at => "desc").first(5)
  end

  def index
    @object_name = "Payment"
    @search_field = :number_cont
    @q = Payment.ransack(params[:q])
    @payments = @q.result.order(:created_at => "desc").page params[:page]
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def create_and_send_new_link
    @payment = Payment.find(params[:id])
    @payment.generate_and_send_new_link
    return redirect_to @payment
  end

  def create
    @product = Product.friendly.find(params[:payment][:product_id])
    @customer = Customer.find_or_create_by(:email => params[:stripeEmail])
    @payment = @product.payments.new(:stripe_params => params)    
    @payment.customer = @customer

    respond_to do |format|
      if @payment.save!
        format.html { redirect_to success_path @payment }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { redirect_to error_path }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def success
    @q = Product.where(:live => true).ransack(params[:q])
    @payment = Payment.find(params[:id])
    render :layout => "shop"
  end

  def error
    @q = Product.where(:live => true).ransack(params[:q])
    render :layout => "shop"
  end

end
