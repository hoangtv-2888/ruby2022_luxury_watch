require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #show" do
    let(:category_1){FactoryBot.create :category}
    let(:product1){FactoryBot.create :product, category: category_1}
    context "when found product"
      it "should load product" do
        get :show, params: {id: product1.id}
        expect(assigns(:product)).to eq product1
      end
      it "should load relate comments" do
        get :show, params: {id: product1.id}
        expect(assigns(:comments)).to eq product1.comment_rates
      end

    context "when not found product" do
      before do
        get :show, params: {id: -1}
      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("not_found")
      end
      it "should redirect to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
