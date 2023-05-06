module ProductsHelper
  def search_cat_name(cat_id)
    @cat = Category.find(cat_id)
    @cat.nombre
  end

  def search_provider_name(prov_id)
    @prov = Proveedor.find(prov_id)
    @prov.nombre
  end

  def base64_image(image)
    "data:image/png;base64,#{Base64.encode64(image)}"
  end
end
