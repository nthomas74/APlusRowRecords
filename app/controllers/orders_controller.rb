class OrdersController < ApplicationController
  def user
    @provinces = Province.all
  end

  def invoice
    @user = User.find(session[:user])
    session_details
  end

  def done
    @user = User.find(session[:user])
    add_order(@user)
    reset_session
  end

  def add_user
    user = User.create(name: params[:customer_name],
                       address: params[:customer_address],
                       city: params[:city],
                       postal_code: params[:postal_code],
                       email: params[:customer_email],
                       phone_number: params[:phone1],
                       is_admin: false,
                       province_id: params[:province])
    if !user.valid?
      flash[:user] = user.errors.messages
      @provinces = Province.all
      render :user
    else
      session[:user] = user.id
      redirect_to('/orders/invoice')
    end
  end

  def add_order(user)
    province = Province.find(user.province_id)
    order = Order.create(status: 'paid',
                         pst_rate: province.pst,
                         gst_rate: province.gst,
                         hst_rate: province.hst,
                         user_id: user.id)
    add_line_items(order)
  end

  def add_line_items(order)
    session[:cart].each do |item|
      product = Product.find(item[0])
      line_item = LineItem.create(quantity: item[1].to_i,
                                  price: product.price,
                                  order_id: order.id,
                                  product_id: product.id)
    end
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
    render :invoice
  end
end
