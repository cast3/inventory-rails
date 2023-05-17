class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?

  def index
    @clients = Client.all.order('created_at DESC')
    @clients = @clients.search(params[:query]) if params[:query].present?
    @pagy, @clients = pagy @clients.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)

    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'index', filename: 'Listado de clientes.xlsx'
      end
    end
  end

  def show; end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)
    @client.puntaje = 0

    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), notice: 'Cliente ha sido creado exitosamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: 'Cliente ha sido actualizado exitosamente.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente ha sido eliminado exitosamente..' }
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:nombre, :cedula, :telefono)
  end

  def sort_column
    %w[nombre cedula referencia telefono puntaje].include?(params[:sort]) ? params[:sort] : 'nombre'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def user_is_admin?
    if current_user.role != 'admin'
      redirect_to inventories_path
    end
  end
end