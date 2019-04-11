module MarketplacesHelper
  def entity_name(id)
    Entity.find_by(id: id).try(:name)
  end
end
