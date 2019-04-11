# frozen_string_literal: true

module EntityHelper
  def get_title
    action_name == 'new' ? t('entity.add_entity') : t('entity.edit_antity')
  end
end
