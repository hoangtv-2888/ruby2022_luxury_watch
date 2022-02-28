require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  let!(:category1){FactoryBot.create :category}
  let!(:category2){FactoryBot.create :category}
  let!(:user1){FactoryBot.create :user, role: 1}

  before do
    sign_in user1
  end

  describe "GET #index" do
    it "should return all categories" do
      get :index
      expect(assigns(:categories)).to eq [category2, category1]
    end
  end

  describe "POST #create" do
    context "when valid params" do
      it "should create a new category" do
        expect do
          post :create, params:{category: {name: "category1"}}
        end.to change {Category.count}.by 1
      end
    end

    context "when invalid params" do
      before do
        post :create, params:{category: {name: ""}}
      end
      it "should flash danger message" do
        expect(flash[:danger]).to eq I18n.t("error")
      end
      it "should render new" do
        expect(subject).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do
    context "when has permissions and success" do
      it "should destroy category" do
        expect do
          delete :destroy, params:{id: category1.id}
        end.to change{Category.count}.by -1
      end
    end
  end

  describe "PATCH #update" do
    context "when has permissions and success" do
      before do
        patch :update, params:{id: category1.id, category:{name: "category new"}}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("success")
      end
    end

    context "when fails" do
      before do
        patch :update, params:{id: category1.id, category:{name: ""}}

      end
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("error")
      end
      it "should render edit" do
        expect(subject).to render_template :edit
      end
    end
  end
end
