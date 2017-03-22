class Product < ApplicationRecord
  belongs_to :artist
  belongs_to :product_type
  has_many :orders
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

end
