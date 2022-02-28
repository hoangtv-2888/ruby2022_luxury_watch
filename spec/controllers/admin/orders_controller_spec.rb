require "rails_helper"

RSpec.describe Admin::OrdersController, type: :controller do
  let(:order1){FactoryBot.create :order}
  let(:order2){FactoryBot.create :order}
  let(:user1){FactoryBot.create :user, role: 1}

  before do
    sign_in user1
  end

  describe "GET #index" do
    it "should return all orders" do
      get :index
      expect(assigns(:orders)).to eq [order1, order2]
    end
  end

  describe "PATCH #update" do
    context "when has permissions and success" do
      before do
        patch :update, params: {id: order1.id, order:{status: "confirmed"}}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("success")
      end
    end
  end
end
