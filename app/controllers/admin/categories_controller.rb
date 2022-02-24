class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource

  def index
    @pagy, @categories = pagy Category.newest
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "success"
      redirect_to admin_category_path @category
    else
      flash[:danger] = t "error"
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to admin_categories_path
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "success"
      redirect_to admin_category_path @category
    else
      flash[:danger] = t "error"
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :desc)
  end
end
