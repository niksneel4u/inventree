# frozen_string_literal: true

require 'mechanize'

class Scraping
  attr_reader :id

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
    send_empty_node if empty_nodes.present?
  end

  private

  def send_empty_node
    AdminMailer.send_empty_node(empty_nodes: empty_nodes, product_id: product.id).deliver_now
  end

  def values_from_scraping(mpm)
    @entity_block = page.search("[#{mpm.entity_identifier}='#{mpm.entity_identifier_value}']")
    @value = get_value_for_entity(mpm, @entity_block)
  end

  def changes_in_entity(product_entity, data_changes)
    product_entity.value = @value
    unless product_entity.changes.blank? || product_entity.new_record?
      data_changes[product_entity.entity.name] = product_entity.changes['value']
    end
    product_entity.update(value: @value)
  end

  def get_value_for_entity(marketplace_mapping, entity_block)
    if entity_block.present?
      return find_image_path(entity_block) if marketplace_mapping.entity.name == I18n.t('image')

      find_entity_value(marketplace_mapping, entity_block)
    else
      empty_nodes << marketplace_mapping.entity.name.titleize
      ''
    end
  end

  def find_entity_value(marketplace_mapping, entity_block)
    if marketplace_mapping.block_present
      block_present_or_not(entity_block)
    else
      begin
        entity_block.text.strip
      rescue StandardError
        ''
      end
    end
  end

  def block_present_or_not(entity_block)
    entity_block.present? ? I18n.t('yes') : I18n.t('no')
  end

  def find_image_path(entity_block)
    product_url.host == I18n.t('amazon') ? amazon_img_path(entity_block) : flipkart_img_path(entity_block)
  end

  def flipkart_img_path(entity_block)
    entity_block.attr('style').value.split('(').last.split(')').first.gsub('128', '612')
  rescue StandardError
    ''
  end

  def amazon_img_path(entity_block)
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

  def empty_nodes
    @empty_nodes ||= []
  end
end
