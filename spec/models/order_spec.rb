require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid with valid attributes" do
    expect(Order.new).to_not be_valid
  end

  describe "Scopes" do
    let!(:user){FactoryBot.create :user, name: "tuongabc"}
    let!(:order_1){FactoryBot.create :order,
                                      user_name_at_order: user.name,
                                      status: Settings.order_shipping,
                                      user_id: user.id}
    let!(:order_2){FactoryBot.create :order,
                                     user_name_at_order: user.name,
                                     status: Settings.order_delivered,
                                     user_id: user.id}

    describe "scope newest" do
      context "with scope newest" do
        it "return list recent order by create at DESC" do
          expect(Order.newest).to eq([order_2, order_1])
        end
      end
    end

    describe "with scope by_status" do
      it "return list order by status" do
        expect(Order.by_status(Settings.order_delivered)).to eq([order_2])
      end
    end

    describe "Search id" do
      context "with scope search id" do
        it "return order with id" do
          expect(Order.search_id(order_1.id)).to eq [order_1]
        end
      end

      context "with scope search by id" do
        it "return order search by id" do
          expect(Order.search_by_id(order_1.id)).to eq [order_1]
        end
      end
    end

    describe "scope search" do
      context "with scope search name" do
        it "search order with user name" do
          result = Order.search("tuongabc")
          expect(result).to eq [order_1, order_2]
        end
      end
    end
  end

  describe "Stauts order" do
    let!(:user){FactoryBot.create :user}
    let!(:order_1){FactoryBot.create :order,
                                  user_id: user.id}

    it "return order can buy again" do
      expect(order_1).to be_status_buy_again
    end
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:discount).optional(:true) }
    it { should have_many(:order_details).dependent(:destroy) }
  end

  describe "Delegates" do
    it { should delegate_method(:name).to(:user).with_prefix(true) }
    it { should delegate_method(:email).to(:user).with_prefix(true) }
  end

  describe "enums" do
    it "define status as an enum" do
      should define_enum_for(:status)
    end
  end

  describe "Validations" do
    context "with field user_name_at_order" do
      it { should validate_presence_of(:user_name_at_order) }
    end
    context "with field address_at_order" do
      it { should validate_presence_of(:address_at_order) }
    end
  end
end
