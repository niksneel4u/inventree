# frozen_string_literal: true

require 'json'

class EntityChangeMailer < ApplicationMailer
  attr_reader :product_entity

  def inform_update(product_entity)
    @product_entity = product_entity
    prepare_data_for_mail
    send_to_all_receiver
  end

  def send_to_all_receiver
    product.company.receiver_emails.each do |receiver|
      @mail_detail[:name] = receiver.name
      mail to: receiver.email, subject: t('subject')
    end
  end

  def prepare_data_for_mail
    changes_in_entity = product_entity.changes[:value]
    @mail_detail = {
      url: product.product_url,
      entity_name: product_entity.entity.name,
      old_value: changes_in_entity[0],
      new_value: changes_in_entity[1]
    }
  end

  def product
    @product ||= product_entity.product
  end
end
