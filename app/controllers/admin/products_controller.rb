class Admin::ProductsController < Admin::AdminController
  before_action :load_product, except: %i(index new create)

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
      handle_create_transaction @product
    end
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      if params.dig(:product, :images)
        @product.images.attach params[:product][:images]
      end
      if @product.update product_params
        flash[:success] = t "success"
        redirect_to admin_product_path @product
      else
        flash.now[:danger] = t "error"
        render :edit
      end
    end
  end

  def show; end

  private

  def load_product
    @product = Product.includes(:product_detail).find_by id: params[:id]
    return if @product

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def product_params
    params.require(:product)
          .permit(:name, :desc, :category_id, :images,
                  product_detail_attributes: [:id,
                                              :quantity,
                                              :price,
                                              :product_size_id,
                                              :product_color_id])
  end

  def handle_create_transaction product
    if product.save
      flash[:success] = t "success"
      redirect_to admin_product_path product
    else
      flash.now[:danger] = t "error"
      render :new
    end
  rescue StandardError => e
    flash.now[:danger] = e
    render :new
  end
end
