class Order < ApplicationRecord
  has_many :line_items
  has_many :products
  belongs_to :user

  # gets order number to display instead of object reference id
  def display_name
    self.id 
  end
end
