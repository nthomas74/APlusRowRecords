class ProductsController < ApplicationController
  def index
    if params.has_key?("srch_term")
#@products = Product.joins(:artist).where('artists.name LIKE ? OR products.name LIKE ?', params[:srch_term], params[:srch_term]).page(params[:page]).per(5).order(:name)
    @products = Product.joins(:artist, :product_type)
      .where("artists.name ILIKE ? OR artists.name ILIKE ? OR artists.name ILIKE ? OR artists.name = ? OR products.name ILIKE ? OR products.name ILIKE ? OR products.name ILIKE ? OR products.name = ? OR product_types.name ILIKE ? OR product_types.name ILIKE ? OR product_types.name ILIKE ? OR product_types.name = ?", \
      "% #{params[:srch_term]}", "#{params[:srch_term]} %", "% #{params[:srch_term]} %", params[:srch_term], \
      "% #{params[:srch_term]}", "#{params[:srch_term]} %", "% #{params[:srch_term]} %", params[:srch_term], \
      "% #{params[:srch_term]}", "#{params[:srch_term]} %", "% #{params[:srch_term]} %", params[:srch_term] \
      ).page(params[:page]).per(5).order(:name)
  #  @products = Product.joins(:artist, :product_type).where(:artists.name @@ to_tsquery(params[:srch_term]))
   else
    #  @products = Product.joins(:artist, :product_type).where(:artists.name @@ to_tsquery(params[:srch_term]))
     #@products = PgSearch.multisearch(params[:srch_term]).page(params[:page]).per(5).order(:name)
     @products = Product.all.page(params[:page]).per(5).order(:name)
    end
    # @search = Product.search  do
    #   keywords(params[:srch_term])
    # end
    # @products = Product.page(params[:page]).per(5).order(:name)
    @artists = Artist.all.order(:name)
    @product_types = ProductType.all.order:name
  end

  def show
    @product = Product.find(params[:id])
  end

  def filter_data
    @artist = params[:product][:artist_id]
    @product_type = params[:product][:product_type_id]
    @on_sale = params.has_key?("on_sale") ? "yes" : "no"
    @new = params.has_key?("new") ? "yes" : "no"

    @products = Product.joins(:artist, :product_type).where('artists.id = ?', @artist).where('product_types.id = ?', @product_type).where("products.on_sale = 'yes' OR products.on_sale = ?", @on_sale).where("products.new = 'yes' OR products.new = ?", @new).page(params[:page]).per(5) unless @artist == "" || @product_type == ""
      if @artist == "" && @product_type == ""
        @products = Product.where("products.on_sale = 'yes' OR products.on_sale = ?", @on_sale).where("products.new = 'yes' OR products.new = ?", @new).page(params[:page]).per(5)

      elsif @artist == ""
        @products = Product.joins(:product_type).where('product_types.id = ?', @product_type).where("products.on_sale = 'yes' OR products.on_sale = ?", @on_sale).where("products.new = 'yes' OR products.new = ?", @new).page(params[:page]).per(5)
      elsif @product_type == ""
        @products = Product.joins(:artist).where('artists.id = ?', @artist).where("products.on_sale = 'yes' OR products.on_sale = ?", @on_sale).where("products.new = 'yes' OR products.new = ?", @new).page(params[:page]).per(5)
      end
    @artists = Artist.all.order(:name)
    @product_types = ProductType.all.order(:name)
    render :index
  end


end
