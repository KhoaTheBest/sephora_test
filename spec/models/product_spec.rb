require "rails_helper"

RSpec.describe Product, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:sold_out).of_type(Mongoid::Boolean) }
  it { is_expected.to have_field(:category).of_type(String) }
  it { is_expected.to have_field(:under_sale).of_type(Mongoid::Boolean) }
  it { is_expected.to have_field(:price).of_type(Integer) }
  it { is_expected.to have_field(:sale_price).of_type(Integer) }
  it { is_expected.to have_field(:sale_text).of_type(String) }
end
