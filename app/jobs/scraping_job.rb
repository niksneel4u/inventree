# frozen_string_literal: true

# job for scraping
class ScrapingJob < ApplicationJob
  queue_as :default

  def perform(id)
    Scraping.new(id).collect_data
  end
end
