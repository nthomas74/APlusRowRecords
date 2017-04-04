class Artist < ApplicationRecord
  has_many :products
  validates :name, :description, presence: true
end
