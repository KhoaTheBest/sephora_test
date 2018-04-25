# Product class
class Product
  include Mongoid::Document
  field :name, type: String
  field :sold_out, type: Mongoid::Boolean
  field :category, type: String
  field :under_sale, type: Mongoid::Boolean
  field :price, type: Integer
  field :sale_price, type: Integer
  field :sale_text, type: String

  def id
    _id.as_json
  end

  def self.filter_by(params)
    self.in(category: params[:filter_categories])
        .and(:price.gte => params[:min_price])
        .and(:price.lte => params[:max_price])
  end
end
