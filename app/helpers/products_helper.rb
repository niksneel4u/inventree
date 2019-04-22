module ProductsHelper
  def entity_name(id)
    Entity.find(id).name.titleize
  end

  def product_image(img)
    img.present? ? img : image_path('logo.png')
  end

  def status(product)
  end

  def product_status(product)
    span_class = product.active? ? 'success' : 'danger'
    content_tag(:div, content_tag(:span, product.status.titleize), class: "badge badge-#{span_class}")
  end

  def active_or_inactive
    text_field_tag checked: "checked", "data-offstyle" => "danger", "data-onstyle" => "success", "data-toggle" => "toggle", type: "checkbox"
  end
end
