module ProductsHelper
  def search_cat_name(cat_id)
    @cat = Category.find(cat_id)
    @cat.nombre
  end

  def search_provider_name(prov_id)
    @prov = Provider.find(prov_id)
    @prov.nombre
  end
end
