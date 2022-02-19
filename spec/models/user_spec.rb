require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
      # nul:false, presence: true のテスト ▼
      context '新規登録できるとき' do

      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end


      it "passwordが6文字以上であれば登録できること" do
        @user.password = "123456"
        @user.encrypted_password = "123456"
        @user.valid?
      end

    end
    context '新規登録できないとき' do

      it "nicknameがない場合は登録できないこと" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it "emailがない場合は登録できないこと" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it "passwordがない場合は登録できないこと" do
        @user.password = ''
        @user.valid?
        include "password can't be blank"
      end

      it "encrypted_passwordがない場合は登録できないこと" do
        @user.encrypted_password = ''
        @user.valid?
        include "encrypted_password can't be blank"
      end

      it "last_nameがない場合は登録できないこと" do
        @user.last_name = ''
        @user.valid?
        include "last_name can't be blank"
      end

      it "last_name_kanaがない場合は登録できないこと" do
        @user.last_name_kana = ''
        @user.valid?
        include "last_name_kana can't be blank"
      end

      it "first_nameがない場合は登録できないこと" do
        @user.first_name = ''
        @user.valid?
        include "first_name can't be blank"
      end

      it "first_name_kanaがない場合は登録できないこと" do
        @user.first_name_kana = ''
        @user.valid?
        include "first_name _kana can't be blank"
      end

      it "birth_dateがない場合は登録できないこと" do
        @user.birth_date = ''
        @user.valid?
        include "password can't be blank"
      end

      # パスワードの文字テスト ▼

      it "passwordは英数字混合でないと登録できない" do
        @user.password = "000000"
        @user.valid?
        include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordは全角文字を含むパスワードでは登録できない" do
        @user.password = "１00000"
        @user.valid?
        include("Password には全角文字を含むパスワードでは登録できません")
      end

      it "passwordが5文字以下であれば登録できないこと" do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      # email 一意性制約のテスト ▼
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        include('Email is invalid')
      end

      it "重複したemailが存在する場合登録できないこと" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        include('Email has already been taken')
      end

      # 確認用パスワードが必要であるテスト ▼

      it "passwordが存在してもencrypted_passwordがない場合は登録できないこと" do
        @user.encrypted_password = ""
        @user.valid?
        include("を入力してください", "は6文字以上で入力してください")
      end

      # 本人確認名前全角入力のテスト ▼

      it 'last_nameが全角入力でなければ登録できないこと' do
        @user.last_name = "ｱｲｳｴｵ"
        @user.valid?
        include("は不正な値です")
      end

      it 'first_nameが全角入力でなければ登録できないこと' do
        @user.first_name = "ｱｲｳｴｵ"
        @user.valid?
        include("は不正な値です")
      end

      # 本人確認カタカナ全角入力のテスト ▼

      it 'last_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.last_name_kana = "あいうえお"
        @user.valid?
        include("は不正な値です")
      end

      it 'first_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.first_name_kana = "あいうえお"
        @user.valid?
        include("は不正な値です")
      end
      end
  end
end