# frozen_string_literal: true
# This Utility is being used for audit logs.
module AuditLogDataHelper
  module_function

  def audit_user_name(audit)
    audit.user.try(:fullname) || I18n.t('system_auditer')
  end

  def audit_message(audit)
    default_audit_message(audit)
  end

  def default_audit_message(audit)
    case audit.action
    when 'create'
      default_create_message(audit)
    when 'update'
      default_update_message(audit)
    when 'destroy'
      default_destroy_message(audit)
    end
  end

  def default_destroy_message(audit)
    if audit.associated_type.present?
      association_message(audit)
    else
      "<ul><li>#{I18n.t('audit_logs.record_destroyed', model: audit.auditable_type.underscore.humanize)}</li></ul>"
    end
  end

  def default_create_message(audit)
    if audit.associated_type.present?
      association_message(audit)
    else
      "<ul><li>#{I18n.t('audit_logs.record_created', model: audit.auditable_type.underscore.humanize)}</li></ul>"
    end
  end

  def association_message(audit)
    changes = audit.audited_changes
    entity_name = Entity.find(changes['entity_id']).name.titleize rescue ''
    value = changes['value']
    "<ul>
      <li>
        #{entity_name} is #{value} for this product.
      </li>
    </ul>"
  end

  def default_update_message(audit)
    message = '<ul>'
    audited_changes = audit.audited_changes
    audited_changes.each do |audited_change|
      audited_change_values = audited_change[1]
      if audit.auditable_type == 'ProductEntity'
        changes = audit.audited_changes
        entity_name = ProductEntity.find(audit.auditable_id).entity.name.titleize rescue ''
        message += "<li>
          Changed <b>#{entity_name}</b> from '#{audited_change_values[0]}' to '#{audited_change_values[1]}'
        </li>"
      else
        message += default_value_update_message(
          audit, audited_change, audited_change_values
        )
      end
    end
    message += '</ul>'
    message
  end

  def default_value_update_message(audit, audited_change, audited_change_values)
    return '' if audited_change_values.nil?

    field = audited_change[0].titleize

    # For normal drop-down data will be : {"group_id"=>[5(old), 2(new)]}
    # For multi-select data will be : {"size"=>[[], ["small"]]}
    values = if foreign_key?(audited_change[0])
              field.constantize.find(audited_change_values).pluck(:name)
            else
              audit_change_values(audited_change_values)
            end

    "<li>#{I18n.t(
      'audit_logs.default_update',
      field: field,
      old_value: values[0],
      new_value: values[1]
    )}</li>"
  end

  def foreign_key?(field)
    (field =~ /_id/).present?
  end

  def audit_change_values(audit_change_values)
    return audit_change_values if audit_change_values.is_a?(String)

    audit_change_values.map { |value| field_value(value) }
  end

  def field_value(audit_change_value)
    if audit_change_value.is_a?(Array)
      audit_change_value.join(',')
    elsif audit_change_value.is_a?(Hash)
      audit_change_value.values.join(',')
    else
      audit_change_value
    end
  end

  def attribute_value(associated_record)
    resource_name, resource_id = associated_record
    resource_class = resource_name.titleize.constantize
    resource_class.find(resource_id).name
  end
end