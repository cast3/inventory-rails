require 'rails_helper'

RSpec.describe "Movements", type: :request do
  describe "GET /registrar_movimiento" do
    it "returns http success" do
      get "/movement/registrar_movimiento"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mostrar_movimientos" do
    it "returns http success" do
      get "/movement/mostrar_movimientos"
      expect(response).to have_http_status(:success)
    end
  end

end
