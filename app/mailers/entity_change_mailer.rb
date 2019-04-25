# frozen_string_literal: true

require 'json'

class EntityChangeMailer < ApplicationMailer
  attr_reader :product, :changes

  def inform_update(product_id:, changes:)
    @product = Product.find(product_id)
    @changes = changes
    send_to_all_receiver
  end

  def send_to_all_receiver
    @product_url = @product.product_url
    product.company.receiver_emails.each do |receiver|
      @receiver_name = receiver.name
      mail to: receiver.email, subject: t('subject')
    end
  end
end
