class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @products = Product.all.order(created_at: :desc)
    @totalProducts = @products

    @products = Product.search_by_name(params[:query]) if params[:query].present?
    @pagy, @products = pagy @products.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)

    nombreExcel = 'Listado de productos ' +  Date.today.strftime('%d-%m-%Y')+'.xlsx'
    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'index', filename: nombreExcel
      end
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    set_product_image

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: 'Producto ha sido creado exitosamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if product_params[:image].present?
        image = product_params[:image].read
        image = Base64.encode64(image)
        @product.image = image
        @product.update(product_params.except(:image))
      else
        @product.update(product_params)
      end

      if @product.save
        format.html { redirect_to product_url(@product), notice: 'Producto ha sido actualizado exitosamente.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    inventoryItem = Inventory.where(product_id: @product.id)

    if inventoryItem.present?
      hasCantidadDisponible = inventoryItem.first.stock
      flash[:alert] = 'No se puede eliminar el producto porque tiene inventario' if hasCantidadDisponible > 0
      redirect_to products_url and return if hasCantidadDisponible > 0
    end

    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Producto ha sido eliminado exitosamente.' }
    end
  end

  private

  def set_product_image
    if params[:product][:image].present?
      image = params[:product][:image].read
      @product.image = Base64.encode64(image)
    else
      default_image_path = Rails.root.join('app', 'assets', 'images', 'default.png')
      default_image = File.open(default_image_path, 'rb').read
      @product.image = Base64.encode64(default_image)
    end
  end

  def sort_column
    %w[nombre referencia precio fecha_caducidad tipo].include?(params[:sort]) ? params[:sort] : 'nombre'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:nombre, :image, :category_id, :precio, :referencia,
                                     :fecha_caducidad)
  end
end
