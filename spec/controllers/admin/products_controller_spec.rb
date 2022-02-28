require "rails_helper"

RSpec.describe Admin::ProductsController, type: :controller do
  let!(:product1){FactoryBot.create :product}
  let!(:product2){FactoryBot.create :product}
  let(:user1){FactoryBot.create :user, role: 1}

  before do
    sign_in user1
  end

  describe "GET #index" do
    it "should return all products" do
      get :index
      expect(assigns(:products)).to eq [product2, product1]
    end
  end

  describe "GET #new" do
    it "should assigns product to @product" do
      get:new
      expect(assigns(:product))
    end
  end

  describe "POST #create" do
    context "when has permissions and success" do
      let(:product_params){FactoryBot.attributes_for :product}
      it "should create new product" do
        expect do
          post :create, params:{product: product_params}
        end.to change{Product.count}.by 1
      end
    end
  end

  describe "PATCH #update" do
    context "when has permissions and success" do
      let(:product_params){FactoryBot.attributes_for :product}
      before do
        patch :update, params:{id: product1.id, product: product_params}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("success")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when has permissions and success" do
      it "should delete the product" do
        expect do
          delete :destroy, params:{id: product1.id}
        end.to change{Product.count}.by -1
      end
    end
  end
end
