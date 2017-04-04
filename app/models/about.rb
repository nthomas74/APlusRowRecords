class About < ApplicationRecord
  validates :title, :description, presence: true

  def display_name
    self.title
  end
end
