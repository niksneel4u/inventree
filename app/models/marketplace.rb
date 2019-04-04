# frozen_string_literal: true

class Marketplace < ApplicationRecord
  has_many :marketplace_mappings, dependent: :destroy
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :marketplace_mappings, allow_destroy: true
end
