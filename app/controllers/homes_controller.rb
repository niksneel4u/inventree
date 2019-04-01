# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :authenticate_user!

  def getproductdetail
    data = Scraping.new(params[:product_link]).collect_data
    render json: { data: data }
  end
end
