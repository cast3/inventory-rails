class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_admin?

  def index
    @perishables = Perishable.all
    @categories = Category.all
    @movements = Movement.all
    @clientes = Client.all
    @proveedores = Provider.all

    @totalClientes = @clientes.count
    @totalCategorias = @categories.count
    @totalProductos = @perishables.count
    @totalProveedores = @proveedores.count
  end

  private

  def user_is_admin?
    if current_user.role != 'admin'
      redirect_to inventories_path
    end
  end
end
