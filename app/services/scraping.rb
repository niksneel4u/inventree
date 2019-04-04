# frozen_string_literal: true

require 'mechanize'

class Scraping
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def collect_data
    marketplace_mappings.each do |mm|
      value = if mm.entity.name == 'image'
                get_image(mm)
              else
                begin
                  page.search(
                    "[#{mm.entity_identifier}='#{mm.entity_identifier_value}']"
                  ).text.strip
                rescue StandardError
                  ''
                end
              end
      product.product_entities.find_or_initialize_by(
        entity_id: mm.entity_id
      ).tap do |product_entity|
        product_entity.update!(value: value)
      end
    end
  end

  private

  def get_image(mm)
    binding.pry
    comman_path = page.search("[#{mm.entity_identifier}='#{mm.entity_identifier_value}']")
    if Addressable::URI.parse(product.product_url).host == 'www.amazon.in'
      begin
      comman_path.children[1].attr('src')
      rescue StandardError
        ''
    end
    else
      begin
        comman_path.attr('style').value.split('(').last.split(')').first.gsub('128', '380')
      rescue StandardError
        ''
      end
    end
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
