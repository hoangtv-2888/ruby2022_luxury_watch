require "rails_helper"

RSpec.describe CommentRatesController, type: :controller do
  let(:category_1){FactoryBot.create :category}
  let(:product_1){FactoryBot.create :product, category_id: category_1.id}
  let(:user1){FactoryBot.create(:user)}
  let(:user2){FactoryBot.create(:user)}
  describe "Post #create" do
    context "when not logged in" do
      it "should redirect to login path" do
        post :create, params:{comment_rate: {content: "abc", star: 4, product_id: product_1.id}}
        expect(response).to redirect_to "http://test.host/users/sign_in"
      end
    end

    context "when logged in" do
      before do
        sign_in user1
      end

      context "when success" do
        it "should create comments" do
          post :create, params:{comment_rate: {content: "abc", star: 4, product_id: product_1.id}}
          expect(assigns(:comment)).to eq product_1.comment_rates.last
        end
      end

      context "when not success" do
        it "shouldn't create comments" do
          post :create, params:{comment_rate: {content: "abc", star: 1000, product_id: product_1.id}}
          expect(assigns(:comment)).not_to eq product_1.comment_rates.last
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "when not logged in" do
      it "should redirect to root path" do
        delete :destroy, params:{id: 1}
        expect(response).to redirect_to "http://test.host/users/sign_in"
      end
    end

    context "when logged in" do
      let!(:comment){CommentRate.create user_id: user1.id,
                                        product_id: product_1.id,
                                        content: "ok",
                                        star: 4}

      context "when success" do
        it "should delete comments" do
          sign_in user1
          expect do
            delete :destroy, params:{id: comment.id}
          end.to change {CommentRate.count}.by -1
        end
      end

      context "when not success" do
        it "shouldn't delete comments" do
          sign_in user2
          expect do
            delete :destroy, params:{id: 1}
            end.to change {CommentRate.count}.by 0
        end
      end
    end
  end
end
