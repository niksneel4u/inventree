# frozen_string_literal: true

# entity model for marketplace product (price,name,..)
class Entity < ApplicationRecord
  has_many :product_entities, dependent: :destroy
  has_many :marketplace_mappings, dependent: :destroy
  belongs_to :product
  validates_uniqueness_of :name, case_sensitive: false
end
