# frozen_string_literal: true

class ProductEntity < ApplicationRecord
  belongs_to :product
  belongs_to :entity
end
