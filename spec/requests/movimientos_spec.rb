require 'rails_helper'

RSpec.describe "Movimientos", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/movimientos/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/movimientos/create"
      expect(response).to have_http_status(:success)
    end
  end

end
