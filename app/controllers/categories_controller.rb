class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]
  before_action :ensure_no_products, only: [:destroy]

  def index
    @categories = Category.all.order(created_at: :desc)
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Categoria ha sido creada exitosamente.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: 'Categoria ha sido actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Categoria ha sido eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private

  def ensure_no_products
    @products = Product.where(category_id: @category.id)
    return unless @products.any?

    flash[:alert] = 'No se puede eliminar la categoría porque tiene productos asociados.'
    redirect_to categories_path
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:nombre)
  end
end
