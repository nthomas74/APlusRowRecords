class ProductsController < ApplicationController
  def index
    if params.key?('srch_term')
      product_for_search
    else
      @products = Product.all.page(params[:page]).per(5).order(:name)
    end
    @artists = Artist.all.order(:name)
    @product_types = ProductType.all.order:name
  end

  def show
    @product = Product.find(params[:id])
  end

  def filter_data
    @artist = params[:product][:artist_id]
    @product_type = params[:product][:product_type_id]
    @on_sale = params.key?('on_sale') ? 'yes' : 'no'
    @new = params.key?('new') ? 'yes' : 'no'

    unless @artist == '' || @product_type == ''
      @products = Product.joins(:artist, :product_type)
                         .where('artists.id = ?', @artist)
                         .where('product_types.id = ?', @product_type)
                         .where('products.on_sale = \'yes\' OR products.on_sale = ?', @on_sale)
                         .where('products.new = \'yes\' OR products.new = ?', @new)
                         .page(params[:page]).per(5)
    end
    if @artist == '' && @product_type == ''
      @products = Product.where('products.on_sale = \'yes\' OR products.on_sale = ?', @on_sale)
                         .where('products.new = \'yes\' OR products.new = ?', @new)
                         .page(params[:page]).per(5)

    elsif @artist == ''
      @products = Product.joins(:product_type)
                         .where('product_types.id = ?', @product_type)
                         .where('products.on_sale = \'yes\' OR products.on_sale = ?', @on_sale)
                         .where('products.new = \'yes\' OR products.new = ?', @new)
                         .page(params[:page]).per(5)
    elsif @product_type == ''
      @products = Product.joins(:artist)
                         .where('artists.id = ?', @artist)
                         .where('products.on_sale = \'yes\' OR products.on_sale = ?', @on_sale)
                         .where('products.new = \'yes\' OR products.new = ?', @new)
                         .page(params[:page]).per(5)
    end
    @artists = Artist.all.order(:name)
    @product_types = ProductType.all.order(:name)
    render :index
  end

  def product_for_search
    @artist = params[:product][:artist_id].to_s
    @products = Product.joins(:artist, :product_type)
                       .where('products.name ILIKE ?'\
                              ' OR products.name ILIKE ?' \
                              ' OR products.name ILIKE ?', \
                              "% #{params[:srch_term]}", "#{params[:srch_term]} %",
                              "% #{params[:srch_term]} %")
                       .page(params[:page]).per(5).order(:name)
    @products = @products.where('artists.id = ?', @artist) if @artist != ''
  end
end
