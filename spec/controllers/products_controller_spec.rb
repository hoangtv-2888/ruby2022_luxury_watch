require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #show" do
    let(:category_1){FactoryBot.create :category}
    let(:product1){FactoryBot.create :product, category: category_1}
    it "should load product" do
      get :show, params: {id: product1.id}
      expect(assigns(:product)).to eq product1
    end
    it "should load relate comments" do
      get :show, params: {id: product1.id}
      expect(assigns(:comments)).to eq product1.comment_rates
    end
  end
end
