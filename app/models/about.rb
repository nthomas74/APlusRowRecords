class About < ApplicationRecord

  def display_name
    self.title
  end

end
