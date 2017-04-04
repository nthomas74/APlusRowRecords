class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  validates :name, :email, :phone_number, presence: true
  validates :phone_number, length: { in: 10..12 }
end
