class Product < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

	validates_presence_of :name
	# validates_presence_of :description
	validates_presence_of :intro
	validates :price_cents, numericality: { greater_than: 0 }
	monetize :price_cents
	has_many :payments
	if Rails.env.production? && ENV['cdn_host_s3_bucket'].present?
		has_attached_file :image, 
			styles: { large: "1000x1000>", medium: "300x300>", thumb: "100x100>" }, 
			:s3_permissions => "public-read",
			:path => "images/:class/:id.:style.:extension",
			:url => ':s3_alias_url',
	    :s3_host_alias => ENV['cdn_host_s3_bucket'] 
	else
		has_attached_file :image, 
			styles: { large: "1000x1000>", medium: "300x300>", thumb: "100x100>" }, 
			:s3_permissions => "public-read",
			:path => "images/:class/:id.:style.:extension"
	end
	has_attached_file :file, :s3_headers => {"Content-Disposition" => "attachment"}
	validates_attachment_presence :file
	validates_attachment_presence :image
	validates_attachment_file_name :file, :matches => [/zip\Z/, /pdf\Z/]
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	before_save :truncate_intro
  # acts_as_hashids length: 10

  def truncate_intro
    self.intro = self.intro[0..139]
  end

	def s3_download_path
    file.s3_object.presigned_url("get", expires_in: ENV['file_expiry_hours'].to_i.hours)
  end

end
