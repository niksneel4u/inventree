# frozen_string_literal: true

require 'mechanize'

class Scraping
  attr_reader :id, :entity_block

  def initialize(id)
    @id = id
  end

  def collect_data
    data_changes = {}
    marketplace_mappings.each do |mm|
      values_from_scraping(mm)
      product.product_entities.find_or_initialize_by(
        entity_id: mm.entity_id
      ).tap do |product_entity|
        changes_in_entity(product_entity, data_changes)
      end
    end
    EntityChangeMailer.inform_update(product_id: product.id, changes: data_changes).deliver_now
  end

  private

  def values_from_scraping(mpm)
    @entity_block = page.search("[#{mpm.entity_identifier}='#{mpm.entity_identifier_value}']")
    @value = get_value_for_entity(mpm)
  end

  def changes_in_entity(product_entity, data_changes)
    product_entity.value = @value
    unless product_entity.changes.blank? || product_entity.new_record?
      data_changes[product_entity.entity.name] = product_entity.changes['value']
    end
    product_entity.update(value: @value)
  end

  def get_value_for_entity(marketplace_mappings)
    return find_image_path if marketplace_mappings.entity.name == 'image'

    find_entity_value(marketplace_mappings)
  end

  def find_entity_value(marketplace_mappings)
    if marketplace_mappings.block_present
      block_present_or_not
    else
      begin
        entity_block.text.strip
      rescue StandardError
        ''
      end
    end
  end

  def block_present_or_not
    entity_block.present? ? I18n.t('yes') : I18n.t('no')
  end

  def find_image_path
    product_url.host == I18n.t('amazon') ? amzon_img_path : flipkart_img_path
  end

  def flipkart_img_path
    entity_block.attr('style').value.split('(').last.split(')').first.gsub('128', '612')
  rescue StandardError
    ''
  end

  def amzon_img_path
    entity_block.children[1].attr('src')
  rescue StandardError
    ''
  end

  def product_url
    Addressable::URI.parse(product.product_url)
  end

  def product
    @product ||= Product.find(id)
  end

  def marketplace
    @marketplace ||= product.marketplace
  end

  def marketplace_mappings
    @marketplace_mappings ||= marketplace.marketplace_mappings
  end

  def agent
    @agent ||= Mechanize.new
  end

  def page
    @page ||= agent.get(product.product_url)
  end
end
