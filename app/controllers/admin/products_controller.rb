class Admin::ProductsController < Admin::AdminController
  load_and_authorize_resource

  def index
    @pagy, @products = pagy Product.newest
  end

  def new
    @product = Product.new
    @product.product_detail.build
  end

  def create
    ActiveRecord::Base.transaction do
      @product = Product.new product_params
      if params.dig(:product, :images)
        @product.images.attach params[:product][:images]
      end
      @product.save!
      flash[:success] = t "success"
      redirect_to admin_product_path @product
    end
  rescue StandardError => e
    flash.now[:danger] = e
    render :new
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      if params.dig(:product, :images)
        @product.images.attach params[:product][:images]
      end
      @product.update! product_params
      flash[:success] = t "success"
      redirect_to admin_product_path @product
    end
  rescue StandardError => e
    flash.now[:danger] = e
    render :edit
  end

  def show; end

  private

  def product_params
    params.require(:product)
          .permit(:name, :desc, :category_id, :images,
                  product_detail_attributes: [:id,
                                              :quantity,
                                              :price,
                                              :product_size_id,
                                              :product_color_id])
  end
end
