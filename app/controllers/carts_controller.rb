class CartsController < ApplicationController
  def index
    @cart_items = session[:cart]
    array_of_ids = []
    @total = 0
    @cart_items.each do |item|
      array_of_ids << item[0]
      @total += (Product.find(item[0]).price * item[1])
    end
    @products = Product.where(id: array_of_ids)
  end

  def refresh_cart
    session[:cart].each do |item|
      item[1] = params[:quantity].to_i if params[:id].to_i == item[0]
    end
    @cart_items = session[:cart]
    array_of_ids = []
    @cart_items.each { |item| array_of_ids << item[0] }
    @products = Product.where(id: array_of_ids)
    render :index
  end
end
