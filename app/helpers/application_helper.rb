module ApplicationHelper

	def amazon_setup_is_incomplete?
		return true if !ENV['AWS_REGION'].present?
		return true if !ENV['AWS_BUCKET'].present?
		return true if !ENV['AWS_ACCESS_KEY_ID'].present?
		return true if !ENV['AWS_SECRET_ACCESS_KEY'].present?
	end

	def stripe_setup_is_incomplete?
		return true if !ENV['stripe_api_key'].present?
		return true if !ENV['stripe_publishable_key'].present?
	end

	def email_setup_is_incomplete?
		return true if !ENV['SMTP_host'].present? && Rails.env.production?
		return true if !ENV['SMTP_port'].present? && Rails.env.production?
		return true if !ENV['SMTP_username'].present? && Rails.env.production?
		return true if !ENV['SMTP_password'].present? && Rails.env.production?
	end

end
