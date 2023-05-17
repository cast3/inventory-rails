class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @providers = Provider.all.order(created_at: :desc)
    @totalProviders = @providers
    @perishables = @providers.search(params[:query]) if params[:query].present?
    @pagy, @providers = pagy @providers.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)

    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'index', filename: 'Listado de proveedores.xlsx'
      end
    end
  end

  def show; end

  def new
    @provider = Provider.new
  end

  def edit; end

  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to providers_url, notice: 'Provider was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to providers_url, notice: 'Provider was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Provider was successfully destroyed.' }
    end
  end

  private

  def sort_column
    %w[nombre precio referencia cantidad categoria].include?(params[:sort]) ? params[:sort] : 'nombre'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:nombre, :direccion, :telefono, :email)
  end
end
