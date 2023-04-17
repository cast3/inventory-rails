class MovimientosController < ApplicationController
  def index; end

  def create
    # @movement = @product.movimientos.build(movement_params)
    @movement = Movimiento.new(movement_params)

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
    end
  end

  private

  def movement_params
    params.require(:movimiento).permit(:tipo, :cantidad, :descripcion, :product_id)
  end
end
