class Product < ApplicationRecord
  belongs_to :artist
  belongs_to :product_type
  has_many :orders
end
