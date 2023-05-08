class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @categories = Category.all
    @movements = Movement.all
    @clientes = Client.all
    @proveedores = Provider.all

    @totalClientes = @clientes.count
    @totalCategorias = @categories.count
    @totalProductos = @products.count
    @totalProveedores = @proveedores.count
  end
end
