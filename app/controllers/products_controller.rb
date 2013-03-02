class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    if params[:aq].present?
      @results = amazon_product_search(params[:aq])
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create

    if Product.unscoped.find_by_asin(params[:asin]).present?
      redirect_to new_product_review_path(Product.unscoped.find_by_asin(params[:asin]))
    else

  # If ASIN not found in Product DB, it's new. Fetch info from Amazon,
  # and re-render new if result is blank, otherwise build / save product,
  # and redirect to new_review_path

      @result = fetch_by_asin(params[:asin])
      if @result.blank?
        render action: "new", notice: "Oops, we couldn't find that product. Try searching instead."
      else
        @product = Product.new(:asin => params[:asin],
                               :amazon_url => @result.first.raw.DetailPageURL,
                               :picture_url => @result.first.raw.LargeImage.present? ? @result.first.raw.LargeImage.URL : '',
                               :name => @result.first.title,
                               :price => fetch_price_for_price(@result),
                               :price_too_low => fetch_price_for_too_low(@result),
                               :amazon_last_updated => Time.now,
                               :product_group => @result.first.raw.ItemAttributes.ProductGroup.present? ? @result.first.raw.ItemAttributes.ProductGroup : '',
                               :description => fetch_desc(@result))
      end
    end

    respond_to do |format|
      if @product.save

        # Build similars after product has saved, if they're present

        if @result.first.raw.SimilarProducts.present?
          @result.first.raw.SimilarProducts.SimilarProduct.each do |similar|
            Similar.new(:product_id => @product.id,
                        :asin => similar.ASIN
            ).save
          end
        end

        # Redirect to new review path

        format.html { redirect_to new_product_review_path(@product) }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private

  def fetch_by_asin(asin)
    require 'asin'
    client = ASIN::Client.instance
    item = client.lookup(asin,
                         :ResponseGroup => [:Images, :ItemAttributes, :OfferSummary, :Similarities, :EditorialReview])
  end

  def amazon_product_search(query)
    require 'asin'
    client = ASIN::Client.instance
    items = client.search(:Keywords => query,
                          :SearchIndex => :All,
                          :ResponseGroup => [:Images, :ItemAttributes, :OfferSummary])
  end

  def fetch_price_for_price(result)
    if result.first.raw.OfferSummary.LowestNewPrice.present?
      if result.first.raw.OfferSummary.LowestNewPrice.FormattedPrice == 'Too low to display'
        return 0
      else
        return result.first.raw.OfferSummary.LowestNewPrice.FormattedPrice
      end
    else
      return 0
    end
  end

  def fetch_price_for_too_low(result)
    if result.first.raw.OfferSummary.LowestNewPrice.present?
      if result.first.raw.OfferSummary.LowestNewPrice.FormattedPrice == 'Too low to display'
        return true
      else
        false
      end
    else
      return false
    end
  end

  def fetch_desc(result)
    if result.first.raw.EditorialReviews.present? && result.first.raw.EditorialReviews.EditorialReview.present?
      if result.first.raw.EditorialReviews.EditorialReview.is_a?(Array)
        return result.first.raw.EditorialReviews.EditorialReview.last.Content
      else
        return result.first.raw.EditorialReviews.EditorialReview.Content
      end
    else
      return ''
    end
  end
end
