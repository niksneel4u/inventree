# frozen_string_literal: true

class MarketplacePolicy
  attr_reader :user, :marketplacepost

  def initialize(user, marketplacepost)
    @user = user
    @marketplacepost = marketplacepost
  end

  def create?
    user.has_role? :admin
  end
end
