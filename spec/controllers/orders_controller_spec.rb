require "rails_helper"
include SessionsHelper
include CartsHelper

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    describe "when not logged in" do
      context "redirect root url" do
        before do
          get :index, params: {type: 0}
        end

        it "redirect to root_url" do
          expect(response).to redirect_to root_url
        end

        it "display flash danger" do
          expect(flash[:danger]).to eq I18n.t("please_login")
        end
      end
    end

    describe "when logged in" do
      context "show order DESC" do
        let!(:user) {FactoryBot.create :user}
        let!(:order_1) {FactoryBot.create :order, user_id: user.id}
        let!(:order_2) {FactoryBot.create :order, user_id:user.id}
        let!(:order_3) {FactoryBot.create :order}
        before do
          log_in user
          get :index, params: {type: 0}
        end

        it "assigns @orders" do
          expect(assigns(:orders)).to eq [order_2, order_1]
        end

        it "render index" do
          expect(response).to render_template(:index)
        end
      end

      context "not found order" do
        let!(:user) {FactoryBot.create :user}
        before do
          log_in user
          get :show, params: {user_id: user.id, id: -1}
        end

        it "redirect to root_url" do
          expect(response).to redirect_to root_url
        end

        it "display flash danger" do
          expect(flash[:danger]).to eq I18n.t("not_found")
        end
      end
    end
  end

   describe "GET #show" do
    let(:user) {FactoryBot.create :user}
    let!(:order) {FactoryBot.create :order, user_id: user.id, status: 0}

    describe "when not logged in" do
      context "redirect root url" do
        before do
          get :show, params: {user_id: order.user.id, id: order.id}
        end

        it "redirect to root_url" do
          expect(response).to redirect_to root_url
        end

        it "display flash danger" do
          expect(flash[:danger]).to eq I18n.t("please_login")
        end
      end
    end

    describe "when logged in" do
      before do
        log_in user
      end

      context "when order exist" do
        before do
          @order = user.orders.find_by id: order.id
          get :show, params: {id: @order.id}
        end

        it "assigns @order" do
          expect(assigns(:order)).to eq @order
        end
        it "renders template show" do
          expect(response).to render_template :show
        end
      end

      context "when order not exist" do
        before do
          get :show, params: {id: -1}
        end

        it "redirect to root_url" do
          expect(response).to redirect_to root_url
        end
        it "display flash danger" do
          expect(flash[:danger]).to eq I18n.t("not_found")
        end
      end
    end
  end

  describe "POST #create" do
    let!(:user) {FactoryBot.create :user}
    let!(:product_1){FactoryBot.create :product, category_id: category_1.id}
    let!(:product_2){FactoryBot.create :product, name: "casio"}
    let!(:product_3){FactoryBot.create :product, name: "abc"}
    let!(:category_1){FactoryBot.create :category}
    let!(:order_1) {FactoryBot.create :order, user_id: user.id}
    let!(:order_detail_1) {FactoryBot.create :order_detail, order_id: order_1.id}
    let!(:product_size_1){FactoryBot.create :product_size, size: 34}
    let!(:product_color_1){FactoryBot.create :product_color}
    let!(:product_size_2){FactoryBot.create :product_size, size: 24}
    let!(:product_color_2){FactoryBot.create :product_color, color: "skyss"}
    let!(:product_detail_1){FactoryBot.create :product_detail, product_id: product_1.id,
                                              product_size_id: product_size_1.id,
                                              product_color_id: product_color_1.id, price: 1000}
    let!(:product_detail_2){FactoryBot.create :product_detail, product_id: product_2.id,
          product_size_id: product_size_2.id,
          product_color_id: product_color_2.id, price: 1000}
    let!(:init_order_count){Order.count}

    before do
      log_in user
      session[:carts] = {}
    end

    context "when current_carts succes" do
      before do
        session[:carts] = {product_detail_1.id => 1, product_detail_2.id => 2}
        post :create, params: {locale: I18n.locale, order: order_1}
        @final_count = Order.count
      end

      it "quantity plus" do
        expect(@final_count - init_order_count).to eq(1)
      end

      it "flash display success" do
        expect(flash[:success]).to eq I18n.t("success")
      end

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when current_carts fail" do
      before do
        session[:carts] = {-2 => 1, -1 => 2}
        post :create, params: {locale: I18n.locale, order: order_1}
        @final_count = Order.count
      end

      it "order not change" do
        expect(@final_count - init_order_count).to eq(0)
      end

      it "flash display error" do
        expect(flash.now[:danger]).to eq I18n.t("error")
      end

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "PUT #update" do
    let!(:user) {FactoryBot.create :user}
    let!(:order) {FactoryBot.create :order, status: :wait, user_id: user.id}
    before do
      log_in order.user
    end

    context "when order status wait" do
      before do
        order.rejected!
        put :update, params: {id: order.id}
      end
      it "check status update" do
        expect(order.status).to eq "rejected"
      end

      it "display flash success" do
        expect(response).to redirect_to root_path
      end
    end

    context "when status not wait" do
      before do
        order.wait!
        put :update, params: {id: order.id}
      end

      it "check status update" do
        expect(order.status).to eq "wait"
      end

      it "display flash danger" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
