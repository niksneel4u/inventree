# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :marketplace
  belongs_to :company
  has_many :product_entities, dependent: :destroy
  after_create :call_scraping_job

  audited
  has_associated_audits

  def call_scraping_job
    ScrapingJob.perform_now(id)
  end
end
