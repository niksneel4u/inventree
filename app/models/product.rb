# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :marketplace
  belongs_to :company
  has_many :product_entities, dependent: :destroy
  after_commit :call_scraping_job, on: :create

  audited
  has_associated_audits

  def call_scraping_job
    ScrapingJob.perform_later(id)
  end
end
