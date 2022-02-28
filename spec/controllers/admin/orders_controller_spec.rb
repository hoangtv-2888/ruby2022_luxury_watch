require "rails_helper"

RSpec.describe Admin::OrdersController, type: :controller do
  let!(:order1){FactoryBot.create :order}
  let!(:order2){FactoryBot.create :order}
  let(:user1){FactoryBot.create :user, role: 1}

  before do
    sign_in user1
  end

  describe "GET #index" do
    it "should return all orders" do
      get :index
      expect(assigns(:orders)).to eq [order1, order2]
    end

    context "when confirm all new order" do
      it "should confirm all orders" do
        post :index, params:{status_change: Settings.order_status.confirmed}
        expect(order1.status).to eq Settings.order_status.wait
      end
    end

    context "when get order by status" do
      it "should return orders by status" do
        get :index, params:{find_status: Settings.order_status.confirmed}
        expect(assigns(:orders)).to eq []
      end
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
