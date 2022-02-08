class Admin::CategoriesController < Admin::AdminController
  before_action :load_category, except: %i(index new create)
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

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "not_found"
    redirect_to admin_root_path
  end

  def category_params
    params.require(:category).permit(:name, :desc)
  end
end
