module ProductsHelper
  def entity_name(id)
    Entity.find(id).name.titleize
  end

  def product_image(img)
    img.present? ? img : image_path('logo.png')
  end

  def formatted_date(date)
    date.try(:to_date).try(:strftime, '%d-%m-%Y')
  end

  def formatted_datetime(datetime)
    datetime.try(:strftime, '%d-%m-%Y %I:%M %p')
  end
end
