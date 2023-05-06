class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @products = Product.all.order(created_at: :desc)
    @products = @products.search(params[:query]) if params[:query].present?
    @pagy, @products = pagy @products.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)

    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'index', filename: 'Listado de productos.xlsx'
      end
    end
  end

  def show
    @movements = Movement.where(product_id: @product.id)
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] =
          "attachment; filename=\"Listado de movimientos - #{@product.id}.xlsx\""
      end
    end
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: 'Producto ha sido creado exitosamente.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   @producto = if params[:tipo] == 'perecedero'
  #                 ProductoPerecedero.new(producto_params)
  #               elsif params[:tipo] == 'duradero'
  #                 ProductoDuradero.new(producto_params)
  #               else
  #                 Producto.new(producto_params)
  #               end

  #   if @producto.save
  #     redirect_to @producto
  #   else
  #     render :new
  #   end
  # end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Producto ha sido actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Producto ha sido eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  ###############################################
  # movement methods
  ###############################################

  def new_movement
    @product = Product.find(params[:id])
    @movement = Movement.new
  end

  def create_movement
    @product = Product.find(params[:id])
    @movement = Movement.new(movement_params)
    @movement.product_id = @product.id
    if @movement.save
      redirect_to products_url, notice: 'Se ha creado un Movimiento Correctamente.'
    else
      flash[:notice] = 'Ha ocurrido un error al crear el Movimiento.'
      render :new_movement, status: :unprocessable_entity
    end
  end

  ###############################################
  # Private methods
  ###############################################

  private

  def sort_column
    %w[nombre precio referencia cantidad categoria].include?(params[:sort]) ? params[:sort] : 'nombre'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def movement_params
    params.require(:movement).permit(:tipo, :cantidad, :descripcion, :provider_id, :client_id, :fecha)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:nombre, :image, :category_id, :provider_id, :precio, :referencia, :cantidad, :tipo, :fecha_caducidad)
  end
end
