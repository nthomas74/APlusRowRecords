class CartsController < ApplicationController
  def index
    session_details
  end

  def refresh_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    update_quantity(id, quantity) if params.key?(:refresh)
    delete_item(id) if params.key?(:delete)
  end

  def update_quantity(id, quantity)
    session[:cart].each do |item|
      item[1] = quantity if id == item[0]
    end
    get_session
  end

  def delete_item(id)
    session[:cart].each do |item|
      session[:cart].delete(item) if id == item[0]
    end
    session_details
  end

  def session_details
    @cart_items = session[:cart]
    array_of_ids = []
    @total = 0
    @cart_items.each do |item|
      array_of_ids << item[0]
      @total += (Product.find(item[0]).price * item[1])
    end
    @products = Product.where(id: array_of_ids)
    render :index
  end
end
