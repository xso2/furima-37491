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

      it "ユーザーと結びついていないと出品出来ない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include ("User must exist")
      end

    it "イメージが空だと保存できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include ("Image can't be blank")
    end

    it "商品名が空だと保存できない" do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it "商品説明が空だと保存できない" do
      @item.introduction = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Introduction can't be blank")
    end

    it "カテゴリーに「---」が選択されている場合は出品できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include ("Category must be other than 1")
    end

    it "商品の状態に「---」が選択されている場合は出品できない" do
      @item.item_condition_id= 1
      @item.valid?
      expect(@item.errors.full_messages).to include ("Item condition must be other than 1")
    end

    it "配送料の負担に「---」が選択されている場合は出品できない" do
      @item.postage_payer_id= 1
      @item.valid?
      expect(@item.errors.full_messages).to include ("Postage payer must be other than 1")
    end

    it "発送元の地域に「---」が選択されている場合は出品できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include ("Prefecture must be other than 1")
    end

    it "発送までの日数に「---」が選択されている場合は出品できない" do
      @item.preparation_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include ("Preparation day must be other than 1")
    end

    it "価格が空だと保存できない" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300円以下だと出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it '価格が9,999,999円以上だと出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it '価格が半角数字でないと出品できない' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it "価格が半角英数混合では登録できないこと" do
      @item.price = "300dollars"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it "価格が半角英語だけでは登録できないこと" do
      @item.price = "threemillion"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not included in the list")
    end
      end
    end
  end
end