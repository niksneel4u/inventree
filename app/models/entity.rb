# frozen_string_literal: true

class Entity < ApplicationRecord
  has_many :product_entities, dependent: :destroy
end
