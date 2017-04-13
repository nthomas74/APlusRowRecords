class Product < ApplicationRecord
  belongs_to :artist
  belongs_to :product_type
  has_many :orders
  has_attached_file :image, styles: { small: '160x160>' }
  validates_attachment_content_type :image,
                                    content_type:
                                    ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]
  paginates_per 5
  validates :name, :description, :price, :stock_quantity, presence: true
  validates :price, :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :new, :on_sale, inclusion: { in: [true, false] }
  validates :new, :on_sale, exclusion: { in: [nil] }

  def self.search_by_category(artist, search_term)
    products = Product.joins(:artist, :product_type)
                      .where('products.name ILIKE ?'\
                             ' OR products.name ILIKE ?' \
                             ' OR products.name ILIKE ?', \
                             "% #{search_term}", "#{search_term} %",
                             "% #{search_term} %")
    products = products.where('artists.id = ?', artist) if artist != ''
    products
  end
end
