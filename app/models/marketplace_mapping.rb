# frozen_string_literal: true

class MarketplaceMapping < ApplicationRecord
  belongs_to :marketplace
  belongs_to :entity
end
