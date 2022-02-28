require "rails_helper"

RSpec.describe HomesController, type: :controller do
  describe "GET #index" do
    let(:category_1){FactoryBot.create :category}
    let(:product_1){FactoryBot.create :product, category_id: category_1.id}
    let(:product_size_1){FactoryBot.create :product_size, size: 38}
    let(:product_color_1){FactoryBot.create :product_color}

    describe "ransack" do
      context "when has not params"
        it "should return all product" do
          get :index
          expect(assigns(:products)).to eq [product_1]
        end
      end

      context "ransack by product_size_id" do
        it "should return product by product_size_id" do
          get :index, params: {q: {product_size_id_eq: '1'}}
          expect(assigns(:products)).to eq [product_1]
        end
      end

      context "ransack by product_size_id and category_id" do
        context "when found" do
          it "should return product by category_id and product_size_id" do
            get :index, params: {q: {product_size_id_eq: '1', category_id_eq: '1'}}
            expect(assigns(:products)).to eq [product_1]
          end
        end

      context "when not found" do
        it "should return product by category_id and product_size_id" do
          get :index, params: {q: {product_size_id_eq: '1', category_id_eq: '2'}}
          expect(assigns(:products)).to eq []
        end
      end
    end
  end

  describe "GET #contact" do
    it "should display contact page" do
      get :contact
      expect(response).to render_template :contact
    end
  end
end
