class Order < ApplicationRecord
  has_many :line_items
  has_many :products
  belongs_to :user
  validates :status, inclusion: { in: %w(paid shipped ordered)}
  validates :pst_rate, :gst_rate, :hst_rate, numericality: {only_integer: true}

  # gets order number to display instead of object reference id
  def display_name
    self.id
  end
end
