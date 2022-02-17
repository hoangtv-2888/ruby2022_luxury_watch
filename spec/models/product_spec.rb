require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Associations" do
    it {should belong_to(:category)}
    it {should have_many(:product_detail).dependent(:destroy)}
    it {should have_many(:comment_rates).dependent(:destroy)}
    it {should have_many(:products).through(:comment_rates)}
    it {should have_many_attached(:images)}
    it {should accept_nested_attributes_for(:product_detail)}
  end

  describe "Validations" do
    context "with field name" do
      subject{FactoryBot.build(:product)}
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.max_name_length)}
    end

    context "with field description" do
      it {should validate_presence_of(:desc)}
      it {should validate_length_of(:desc).is_at_most(Settings.max_comment_length)}
    end

    context "with field images" do
      it {should have_many_attached(:images)}
    end
  end

  describe "Scope" do
    let!(:category_1){FactoryBot.create :category}
    let!(:category_2){FactoryBot.create :category}
    let!(:product_1){FactoryBot.create :product, category_id: category_1.id}
    let!(:product_2){FactoryBot.create :product, name: "casio"}
    let!(:product_3){FactoryBot.create :product, name: "abc"}
    let!(:product_size_1){FactoryBot.create :product_size, size: 38}
    let!(:product_color_1){FactoryBot.create :product_color}
    let!(:product_size_2){FactoryBot.create :product_size, size: 39}
    let!(:product_color_2){FactoryBot.create :product_color, color: "sky bluee"}
    let!(:product_detail_1){FactoryBot.create :product_detail, product_id: product_1.id,
                                               product_size_id: product_size_1.id,
                                               product_color_id: product_color_1.id, price: 1000}
    let!(:product_detail_2){FactoryBot.create :product_detail, product_id: product_2.id,
                                               product_size_id: product_size_2.id,
                                               product_color_id: product_color_2.id, price: 1000}
    let!(:order_detail_1){FactoryBot.create :order_detail, quantity: 10,
                                             price_at_order: 1000,
                                             product_detail_id: product_detail_1.id}
    let!(:order_detail_2){FactoryBot.create :order_detail, quantity: 100,
                                             price_at_order: 1000,
                                             product_detail_id: product_detail_2.id}
    describe ".newest" do
      it "should return list products order by create at DESC" do
        expect(Product.newest).to eq([product_3, product_2, product_1])
      end
    end

    describe ".search_by_name" do
      context "when found" do
        it "shoud search product by name" do
          expect(Product.search_by_name("casio")).to eq [product_2]
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Product.search_by_name("ccc")).to eq []
        end
      end
    end

    describe ".filter_by_category_id" do
      context "when found" do
        it "should filter product by category" do
          expect(Product.filter_by_category_id(category_1.id)).to eq [product_1]
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Product.filter_by_category_id(1000)).to eq []
        end
      end
    end

    describe ".filter_by_product_size_id" do
      context "when found" do
        it "should filter products by size id" do
          expect(Product.filter_by_product_size_id(product_size_1.id)).to eq [product_1]
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Product.filter_by_product_size_id(100)).to eq []
        end
      end
    end

    describe ".filter_by_product_color_id" do
      context "when found" do
        it "shoud filter products by color id" do
          expect(Product.filter_by_product_color_id(product_color_1.id)).to eq [product_1]
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Product.filter_by_product_color_id(1000)).to eq []
        end
      end
    end

    describe ".filter_by_max_price" do
      context "when found" do
        it "shoud filter products by max price" do
          expect(Product.filter_by_max_price(1002)).to eq [product_1, product_2]
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Product.filter_by_max_price(1)).to eq []
        end
      end
    end

    describe ".filter_by_min_price" do
      context "when found" do
        it "should filter by min price" do
          expect(Product.filter_by_min_price(1)).to eq([product_1, product_2])
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Product.filter_by_min_price(99999)).to eq []
        end
      end
    end

    describe "with hot_sell" do
      it "should return list hot sell product by sold quantity DESC" do
        expect(Product.hot_sell(2)).to eq([product_2,product_1])
      end
    end
  end

  describe "#display_image" do
    let(:product_1){FactoryBot.create :product}
    let(:product_2){FactoryBot.create :product}
    context "when found" do
      it "should display image" do
        product_1.images.attach(io: File.open("app/assets/images/p-#{rand(1..8)}.png"), filename: 'watch', content_type: %w[image/jpeg image/gif image/png image/jpg])
        expect(product_1.display_image(product_1.images.first)).to be_present
      end
    end
    context "when not found" do
      it "should be empty" do
        expect(product_2.display_image(product_2.images.first)).to be_nil
      end
    end
  end

  describe "#qua_pro_first" do
    let(:product_1){FactoryBot.create :product}
    let(:product_2){FactoryBot.create :product}
    context "when found" do
      let!(:product_detail_1){FactoryBot.create :product_detail, product_id: product_1.id}
      it "should return first quantity of product details" do
        expect(product_1.qua_pro_first).to be_present
      end
    end
    context "when not found" do
      it "should be empty" do
        expect(product_2.qua_pro_first).to be_nil
      end
    end
  end
end
