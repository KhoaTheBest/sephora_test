# Products Controller
class Api::V1::ProductsController < ApplicationController
  before_action :set_current_product, only: [:show]

  # GET: products with query
  def index
    filter_categories = params[:c].present? ? params[:c].split(",") : []
    min_price = params[:min_pr].present? ? params[:min_pr].to_i : 0
    max_price = params[:max_pr].present? ? params[:max_pr].to_i : 0
    sort_by_price = params[:sort].presence || "desc"
    page = params[:page].present? ? params[:page].to_i : 1

    @products = Product.filter_by(filter_categories: filter_categories,
                                  min_price: min_price,
                                  max_price: max_price)
                       .order_by(price: sort_by_price)
                       .page(page).per(3)
  end

  def show
  end

  private

  def set_current_product
    @product = Product.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: {
      msg: "Not Found"
    }, status: :not_found
  end
end
