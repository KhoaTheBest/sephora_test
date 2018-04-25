require "rails_helper"

RSpec.describe Api::V1::ProductsController, type: :controller do
  render_views
  context "GET: List of Products" do
    context "when list of products is empty" do
      before do
        get "api/v1/products", format: :json
      end

      it_behaves_like "respond to success"

      it "respond with a message of Empty List" do
        message = json["msg"]
        expect(message).to eq("Empty List")
      end
    end

    context "when list of products is not empty" do
      before do
        load Rails.root + "db/seeds.rb"
        get "api/v1/products?c=makeup,hair,face,body&min_pr=0&max_pr=5000&sort=desc&page=1", format: :json
      end

      it_behaves_like "respond to success"

      it "respond with Products in DB" do
        expect(json["products"]).not_to be_empty
      end

      context "respond with a defined JSON Format" do
        subject { json["products"].first.to_json }

        it "includes 'id'" do
          is_expected.to have_json_path("id")
          is_expected.to have_json_type(String).at_path("id")
        end

        it "includes 'name'" do
          is_expected.to have_json_path("name")
          is_expected.to have_json_type(String).at_path("name")
        end

        it "includes 'sold_out'" do
          is_expected.to have_json_type(:boolean).at_path("sold_out")
          is_expected.to have_json_path("sold_out")
        end
        it "includes 'category'" do
          is_expected.to have_json_type(String).at_path("category")
          is_expected.to have_json_path("category")
        end
        it "includes 'under_sale'" do
          is_expected.to have_json_type(:boolean).at_path("under_sale")
          is_expected.to have_json_path("under_sale")
        end
        it "includes 'price'" do
          is_expected.to have_json_type(Integer).at_path("price")
          is_expected.to have_json_path("price")
        end
        it "includes 'sale_price'" do
          is_expected.to have_json_type(Integer).at_path("sale_price")
          is_expected.to have_json_path("sale_price")
        end
        it "includes 'sale_text'" do
          is_expected.to have_json_type(String).at_path("sale_text")
          is_expected.to have_json_path("sale_text")
        end
      end
    end
  end

  context "GET: Product" do
    context "when Product is not found" do
      subject { controller }
      it_behaves_like "respond to missing", "api/v1/products/-1"
    end

    context "when Product is found by given ID" do
      before do
        load Rails.root + "db/seeds.rb"
        get "api/v1/products/#{Product.first.id}", format: :json
      end

      it_behaves_like "respond to success"

      context "responds with a defined JSON Format" do
        subject { json["product"].to_json }

        it "includes 'id'" do
          is_expected.to have_json_path("id")
          is_expected.to have_json_type(String).at_path("id")
        end

        it "includes 'name'" do
          is_expected.to have_json_path("name")
          is_expected.to have_json_type(String).at_path("name")
        end

        it "includes 'sold_out'" do
          is_expected.to have_json_type(:boolean).at_path("sold_out")
          is_expected.to have_json_path("sold_out")
        end
        it "includes 'category'" do
          is_expected.to have_json_type(String).at_path("category")
          is_expected.to have_json_path("category")
        end
        it "includes 'under_sale'" do
          is_expected.to have_json_type(:boolean).at_path("under_sale")
          is_expected.to have_json_path("under_sale")
        end
        it "includes 'price'" do
          is_expected.to have_json_type(Integer).at_path("price")
          is_expected.to have_json_path("price")
        end
        it "includes 'sale_price'" do
          is_expected.to have_json_type(Integer).at_path("sale_price")
          is_expected.to have_json_path("sale_price")
        end
        it "includes 'sale_text'" do
          is_expected.to have_json_type(String).at_path("sale_text")
          is_expected.to have_json_path("sale_text")
        end
      end
    end
  end
end
