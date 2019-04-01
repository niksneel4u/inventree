# frozen_string_literal: true

require 'mechanize'

class Scraping
  attr_reader :price, :marketplace, :flipkart_assured_class

  def initialize(link)
    agent = Mechanize.new
    page = agent.get(link)
    @price = page.search("[@class='_1vC4OE _3qQ9m1']").text
    @marketplace = 'flipkart'
    @flipkart_assured_class = '_3V7-QV _55FW5e'
  end

  def collect_data
    { price: price, marketplace: marketplace, flipkartAssured: flipkart_assured_class }
  end
end
