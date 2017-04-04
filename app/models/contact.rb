class Contact < ApplicationRecord
  validates :name, :data, presence: true
end
