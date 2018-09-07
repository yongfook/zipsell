class ApplicationMailer < ActionMailer::Base
	default from: "#{ENV['shop_email_noreply']}"
  layout 'mailer'

  def admin_new_payment(id)
  	@payment = Payment.find(id)
  	mail(to: Admin.first.email, subject: "New revenue #{@payment.product.price.currency.symbol}#{@payment.product.price}", :from => "#{ENV['shop_name']} <#{ENV['shop_email_noreply']}>")

  end

end
