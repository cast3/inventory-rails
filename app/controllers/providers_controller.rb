class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show edit update destroy]
  before_action :ensure_no_products, only: [:destroy]

  # GET /providers or /providers.json
  def index
    @providers = Provider.all.order(created_at: :desc)
  end

  # GET /providers/1 or /providers/1.json
  def show; end

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit; end

  # POST /providers or /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to provider_url(@provider), notice: 'Proveedor ha sido creado exitosamente.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1 or /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to provider_url(@provider), notice: 'Proveedor ha sido actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1 or /providers/1.json
  def destroy
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Proveedor ha sido eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private

  def ensure_no_products
    @products = Product.where(provider_id: @provider.id)
    return unless @products.any?

    flash[:alert] = 'No se puede eliminar la categoría porque tiene productos asociados.'
    redirect_to providers_path
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_provider
    @provider = Provider.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def provider_params
    params.require(:provider).permit(:nombre, :telefono, :direccion)
  end
end
