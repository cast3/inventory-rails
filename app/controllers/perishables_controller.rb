class PerishablesController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @perishables = Perishable.all.order(sort_column => sort_direction)
    @totalProducts = @perishables
    @pagy, @perishables = pagy @perishables.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)

    nombreExcel= "Listado de productos " + Date.today.strftime('%d-%m-%Y')+'.xlsx'
    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'index', filename: nombreExcel
      end
    end
  end

  def new
    @perishable = Perishable.new
  end

  def create
    @perishable = Perishable.create(product_params)

    set_product_image

    puts @perishable.inspect

    respond_to do |format|
      if @perishable.save
        format.html { redirect_to perishable_url(@perishable), notice: 'Producto ha sido creado exitosamente.' }
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
        @perishable.image = image
        @perishable.update(product_params.except(:image))
      else
        @perishable.update(product_params)
      end

      if @perishable.save
        format.html { redirect_to perishable_url(@perishable), notice: 'Producto ha sido actualizado exitosamente.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    inventoryItem = Inventory.where(product_id: @perishable.id)

    if inventoryItem.present?
      hasCantidadDisponible = inventoryItem.first.stock
      flash[:alert] = 'No se puede eliminar el producto porque tiene inventario' if hasCantidadDisponible > 0
      redirect_to perishables_url and return if hasCantidadDisponible > 0
    end

    @perishable.destroy
    respond_to do |format|
      format.html { redirect_to perishables_url, notice: 'Producto ha sido eliminado exitosamente.' }
    end
  end

  private

  def set_product_image
    if params[:perishable][:image].present?
      image = params[:perishable][:image].read
      @perishable.image = Base64.encode64(image)
    else
      default_image_path = Rails.root.join('app', 'assets', 'images', 'default.png')
      default_image = File.open(default_image_path, 'rb').read
      @perishable.image = Base64.encode64(default_image)
    end
  end

  def sort_column
    %w[nombre referencia precio fecha_caducidad].include?(params[:sort]) ? params[:sort] : 'nombre'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_product
    @perishable = Perishable.find(params[:id])
  end

  def product_params
    params.require(:perishable).permit(:nombre, :image, :category_id, :precio, :referencia, :fecha_caducidad)
  end
end
