class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :ensure_has_enough_products, only: [:create_movement]

  def index
    @inventories = Inventory.joins(:product).order('products.fecha_caducidad ASC')
    @totalInventories = @inventories

    @inventories = Product.search_by_name(params[:query]) if params[:query].present?
    @pagy, @inventories = pagy @inventories.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)

    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'index', filename: 'Listado de inventario.xlsx'
      end
    end
  end

  def show
    @inventory = Inventory.find(params[:id])
    @movements = Movement.where(inventory_id: @inventory.id)
    @providers = Provider.joins(:movements).where(movements: { inventory_id: @inventory.id }).all.uniq
    @product = Product.find(@inventory.product_id)

    respond_to do |format|
      format.html
      format.xlsx do
        if @movements.present?
          response.headers['Content-Disposition'] =
            "attachment; filename=\"Listado de movimientos - #{@inventory.id}.xlsx\""
        else
          flash[:notice] = 'No hay movimientos para este producto.'
          redirect_to inventory_path(id: @inventory.id)
        end
      end
    end
  end

  def new
    @inventory = Inventory.new
  end

  def edit; end

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: 'Producto agregado al inventario exitosamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html do
          redirect_to inventory_url(@inventory), notice: 'Inventario de producto actualizado exitosamente.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'Inventario de producto eliminado exitosamente.' }
    end
  end

  def new_movement
    @inventory = Inventory.find(params[:id])
    @movement = Movement.new
  end

  def create_movement
    @inventory = Inventory.find(params[:id])
    @movement = Movement.new(movement_params)
    @movement.inventory_id = @inventory.id

    # TODO: validar que la cantidad no sea mayor al stock
    if @movement.save
      redirect_to inventory_path(id: @inventory.id), notice: 'Movimiento creado exitosamente.'
    else
      flash[:notice] = 'Ha ocurrido un error al crear el Movimiento.'
      render :new_movement, status: :unprocessable_entity
    end
  end

  private

  def ensure_has_enough_products
    @inventory = Inventory.find(params[:id])
    @movement = Movement.new(movement_params)
    @movement.inventory_id = @inventory.id

    return unless @movement.tipo_movimiento == 'Salida'
    return unless @movement.cantidad > @inventory.stock

    flash[:notice] = 'No hay suficientes productos en el inventario.'
    render :new_movement, status: :unprocessable_entity
  end

  def movement_params
    params.require(:movement).permit(:tipo_movimiento, :cantidad, :descripcion, :provider_id, :client_id, :inventory_id)
  end

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:product_id, :stock, :cantidad_minima)
  end

  def sort_column
    Inventory.column_names.include?(params[:sort]) ? params[:sort] : 'product_id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
