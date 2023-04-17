class ProductsController < ApplicationController
  before_action :set_product, only: %i[create_movement show edit update destroy new_movement]

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @movement = Movimiento.new
    @movements = @product.movimientos.order(created_at: :desc)
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

  def create_movement
    @movement = @product.movimientos.build(params)
    # @movement = Movimiento.new(movement_params)

    if @movement.save
      # flash.now[:notice] = 'User was successfully created.'
      # render turbo_stream: [
      #   turbo_stream.prepend('movements', @movement),
      #   turbo_stream.replace(
      #     'form_movement',
      #     partial: 'form-movement',
      #     locals: { movement: @movement }
      #   ),
      #   turbo_stream.replace('notice', partial: 'layouts/flash')
      # ]
    else
      # render :new, status: :unprocessable_entity
      p '*' * 100
      p @movement.errors.full_messages
    end
  end

  def new_movement
    @movement = Movimiento.new(product_id: @product.id)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:nombre, :referencia, :fecha_expiracion, :provider_id, :category_id)
  end

  def movement_params
    params.require(:movement).permit(:tipo, :cantidad, :descripcion)
  end
end
