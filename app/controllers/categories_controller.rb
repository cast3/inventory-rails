class CategoriesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]
  before_action :ensure_no_products, only: [:destroy]

  def index
    @category = Category.new
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    @category_new = Category.new

    respond_to do |format|
      if @category.save
        format.turbo_stream
        format.html
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.turbo_stream
        format.html
      end
    end
  end

  def destroy
    @category.destroy
    streams = []
    streams << turbo_stream.remove(dom_id(@category).to_s)
    render turbo_stream: streams
  end

  private

  def ensure_no_products
    @products = Product.where(category_id: @category.id)
    return unless @products.any?

    redirect_to categories_path
    flash[:alert] = 'No se puede eliminar la categoría porque tiene productos asociados.'
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:nombre)
  end
end
