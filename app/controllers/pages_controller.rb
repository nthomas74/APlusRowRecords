class PagesController < ApplicationController
  def about
    @about = About.first
  end

  def contact
    @contacts = Contact.all
  end
end
