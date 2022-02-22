require "rails_helper"
include SessionsHelper
RSpec.describe UsersController, type: :controller do
  let(:user){FactoryBot.create(:user)}
  describe "GET #new" do
    it "should render new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    context "when user not found" do
      before do
        get :edit, params: {id: -1}
      end
      it "should flash danger" do
        expect(flash[:danger]).to be_present
      end
      it "should redirect root_path" do
        expect(response).to redirect_to root_path
      end
    end

    context "when user found" do
      before do
        get :edit, params: {id: user.id}
      end
      it "should assign user to user" do
        expect(assigns(:user)).to eq user
      end
      it "should redirect root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    context "when invalid params" do
      before do
        post :create, params: {user: {name: ""}}
      end
      it "should render new" do
        expect(response).to render_template :new
      end
    end
    context "when valid params" do
      let(:user){FactoryBot.attributes_for :user}
      before do
        post :create, params: {user: user}
      end
      it "should flash infor" do
        expect(flash[:info]).to be_present
      end
      it "should create new user" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "PUT #update" do
    let(:user){FactoryBot.create :user}
    context "when valid attributes" do
      let(:user_params){FactoryBot.attributes_for :user}
      before do
        user.activated = true
        user.save
        log_in user
        current_user
        put :update, params: {id: user.id, user: user_params}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("user.profile_updated")
      end
      it "should redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end
    context "when invalid attributes" do
      let(:user_parms){FactoryBot.attributes_for(:user, name: "")}
      before do
        user.activated = true
        user.save
        log_in user
        current_user
        put :update, params: {id: user.id, user: user_parms}
      end
      it "should render edit" do
        get :edit, params: {id: user.id}
      end
    end
  end
end
