require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

describe Item do
  describe '商品の出品' do

    context '商品の出品が出来る時' do

    it '全ての項目が存在すれば登録できる' do
      expect(@item).to be_valid
      end
    end

    context '商品の出品が出来ない時' do

    it "イメージが空だと保存できない" do
      @item.image = nil
      @item.valid?
      include("を入力してください")
    end

    it "商品名が空だと保存できない" do
      @item.name = ""
      @item.valid?
      include("を入力してください")
    end

    it "商品説明が空だと保存できない" do
      @item.introduction = ""
      @item.valid?
      include("を入力してください")
    end

    it "カテゴリーが空だと保存できない" do
      @item.category_id =""
      @item.valid?
      include("を入力してください")
    end

    it "商品状態が空だと保存できない" do
      @item.item_condition_id = ""
      @item.valid?
      include("を入力してください")
    end

    it "配送料が空だと保存できない" do
      @item.postage_payer_id = ""
      @item.valid?
      include("を入力してください")
    end

    it "配送方法が空だと保存できない" do
      @item.preparation_day_id = ""
      @item.valid?
      include("を入力してください")
    end

    it "販売価格が空だと保存できない" do
      @item.price = ""
      @item.valid?
      include("300以上9999999以下で入力してください")
        end
      end
    end
  end
end