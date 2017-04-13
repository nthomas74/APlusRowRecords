class About < ApplicationRecord
  validates :title, :description, presence: true

  def display_name
    title
  end
end
