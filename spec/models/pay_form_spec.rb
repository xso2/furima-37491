require 'rails_helper'

RSpec.describe PayForm, type: :model do
  describe '購入記録と配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      sleep 0.5
      @pay_form = FactoryBot.build(:pay_form, user_id: user.id, item_id: item.id)
    end

    context '購入にかかる情報の入力に問題がない場合' do
      it 'すべての値が正しく入力されていれば送信に成功する' do
        expect(@pay_form).to be_valid
      end
      it 'building_nameは空でも送信に成功する' do
        @pay_form.building_name = ''
        expect(@pay_form).to be_valid
      end
    end

    context '購入にかかる情報の入力に問題がある場合' do
      it 'post_codeが空だと送信に失敗する' do
        @pay_form.post_code = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Post code can't be blank")
      end
      it 'prefectureが未選択だと送信に失敗する' do
        @pay_form.prefecture_id = 1
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと送信に失敗する' do
        @pay_form.city = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと送信に失敗する' do
        @pay_form.house_number = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと送信に失敗する' do
        @pay_form.phone_number = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと送信に失敗する' do
        @pay_form.post_code = '1234567'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'post_codeが全角数字だと送信に失敗する' do
        @pay_form.post_code = '１２３-４５６７'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'phone_numberが全角数字だと送信に失敗する' do
        @pay_form.phone_number = '０９０１２３４５６７８'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberにハイフンが含まれていると送信に失敗する' do
        @pay_form.phone_number = '090-1234-5678'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが9桁以下だと送信に失敗する' do
        @pay_form.phone_number = '090123456'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが12桁以上だと送信に失敗する' do
        @pay_form.phone_number = '090123456789'
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include('Phone number is invalid')
      end
      it 'userが紐付いていないと送信に失敗する' do
        @pay_form.user_id = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと送信に失敗する' do
        @pay_form.item_id = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが存在していないと送信に失敗する' do
        @pay_form.token = nil
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end