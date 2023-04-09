class CategoriesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]
  before_action :ensure_no_products, only: [:destroy]

  # GET /categories or /categories.json
  def index
    @category = Category.new
    @categories = Category.all.order(created_at: :desc)
  end

  # GET /categories/1 or /categories/1.json
  def show; end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      streams = []
      streams << turbo_stream.prepend('categories', partial: 'categories/category', locals: { category: @category })
      streams << turbo_stream.prepend('form_category', partial: 'categories/form', locals: { category: @category })
      render turbo_stream: streams
    else
      flash[:alert] = 'No se pudo crear la nota.'
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    streams = []
    if @category.update(category_params)
      streams << turbo_stream.replace('edit_category', partial: 'categories/category', locals: { category: @category })
      streams << turbo_stream.replace(dom_id(@category).to_s, partial: 'categories/category',
                                                              locals: { category: @category })
    else
      flash[:alert] = 'No se pudo actualizar la nota.'
    end

    render turbo_stream: streams
  end

  # DELETE /categories/1 or /categories/1.json
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

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:nombre)
  end
end
