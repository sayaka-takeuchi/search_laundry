require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての値が正しく入力されている場合保存ができること' do 
      expect(@user).to be_valid
    end

    it 'ニックネームが空の場合登録ができないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが空の場合登録ができないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスに@が含まれていない場合登録ができないこと' do
      @user.email = 'test.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'すでに同じメールアドレスが登録されている場合登録ができないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    
    it 'パスワードが空の場合登録ができないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードが５文字以下の場合登録ができないこと' do
      @user.password = 'aaa11'
      @user.password_confirmation = 'aaa11'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'パスワードが半角数字のみの場合登録ができないこと' do
      @user.password = '11111'
      @user.password_confirmation = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end

    it 'パスワードが半角英字のみの場合登録ができないこと' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end

    it 'パスワード（確認用）が空の場合登録ができないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

    end
    it 'パスワード（確認用）とパスワードが異なる場合登録ができないこと' do
      @user.password = 'aaa111'
      @user.password_confirmation = 'aaaaa1'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '苗字(fitst_name)が空の場合登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '苗字(fitst_name)が全角日本語ではない場合登録できないこと' do
      @user.first_name = 'ｽｽﾞｷ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name には全角日本語を使用してください")
    end

    it '名前(last_name)が空の場合登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it '名前(last_name)が全角日本語ではない場合登録できないこと' do
      @user.last_name = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name には全角日本語を使用してください")
    end

    it '苗字カナ(fitst_name_kana)が空の場合登録できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it '苗字カナ(fitst_name_kana)が全角カタカナではない場合登録できないこと' do
      @user.first_name_kana = 'suzuki'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end

    it '名前カナ(last_name_kana)が空の場合登録できないこと' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it '名前カナ(last_name_kana)が全角カタカナではない場合登録できないこと' do
      @user.last_name_kana = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana には全角カタカナを使用してください")
    end
  end
end