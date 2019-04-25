# frozen_string_literal: true

# miler for send mail to admin from scrapping if entity data not found
class AdminMailer < ApplicationMailer
  def send_empty_node(empty_nodes: [], product_id:)
    @empty_nodes = empty_nodes
    @product_url = Product.find_by(id: product_id).try(:product_url)
    mail to: Rails.application.credentials.dig(:admin, :email), subject: t('subject')
  end
end
