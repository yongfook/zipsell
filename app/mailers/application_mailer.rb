class ApplicationMailer < ActionMailer::Base
	default from: "#{ENV['shop_email_noreply']}"
  layout 'mailer'

  def admin_new_payment(id)
  	@payment = Payment.find(id)
  	mail(to: Admin.first.email, subject: "New revenue #{@payment.product.price.currency.symbol}#{@payment.product.price}", :from => "#{ENV['shop_name']} <#{ENV['shop_email_noreply']}>")
  end

  def customer_new_payment(id)
  	@payment = Payment.find(id)
  	mail(to: @payment.customer.email, subject: "Download #{@payment.product.name} now", :from => "#{ENV['shop_name']} <#{ENV['shop_email_noreply']}>")
  end

  def customer_new_link(id)
    @payment = Payment.find(id)
    mail(to: @payment.customer.email, subject: "New download link for #{@payment.product.name} now", :from => "#{ENV['shop_name']} <#{ENV['shop_email_noreply']}>")
  end

end
