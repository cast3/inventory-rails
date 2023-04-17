class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all.order(created_at: :desc)
    @categories = Category.all.order(created_at: :desc)
    # @movements = Movimiento.all.order(created_at: :desc)
    @clientes = Client.all.order(created_at: :desc)
    @movements = Movimiento.all.order(created_at: :desc)
  end
end
