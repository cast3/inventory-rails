module InventoryHelper
  def search_product_ByID(prod_id)
    @prod = Product.find(prod_id)
  end
end
