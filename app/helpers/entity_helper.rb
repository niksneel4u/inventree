# frozen_string_literal: true

module EntityHelper
  def get_title
    action_name == 'new' ? t('entity.add_entity') : t('entity.edit_antity')
  end

  def non_deletable_entity?(entity_name)
    Entity::NON_DELETABLE_ENTITIES.include?(entity_name)
  end
end
