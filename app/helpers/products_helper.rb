module ProductsHelper
  def entity_name(id)
    Entity.find(id).name.titleize
  end

  def product_image(img)
    img.present? ? img : image_path('logo.png')
  end
end
