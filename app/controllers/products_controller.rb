class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(5)
    @artists = Artist.all
    @product_types = ProductType.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def filter_data
    @artist = params[:product][:artist_id]
    @product_type = params[:product][:product_type_id]
  #  @products = Product.where(artist.name = @artist).page(params[:page]).per(5)
    @products = Product.joins(:artist, :product_type).where('artists.id = ?', @artist).where('product_types.id = ?', @product_type).page(params[:page]).per(5)
    @artists = Artist.all
    @product_types = ProductType.all
    render :index
  end
end
