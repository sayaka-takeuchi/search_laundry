require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく場合' do
      it '全ての値が正しく入力されている場合保存ができること' do
        expect(@user).to be_valid
      end

      it 'パスワードが６文字の場合登録ができること' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa111'
        expect(@user).to be_valid
      end

      it 'パスワードが7文字以上の場合も登録ができること' do
        @user.password = 'password1234'
        @user.password_confirmation = 'password1234'
        expect(@user).to be_valid
      end

      it 'パスワードが半角英数字混合であれば登録ができること' do
        @user.password = 'aaaa1111'
        @user.password_confirmation = 'aaaa1111'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない場合' do
      it 'ニックネームが空の場合登録ができないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'メールアドレスが空の場合登録ができないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end

      it 'メールアドレスに@が含まれていない場合登録ができないこと' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'すでに同じメールアドレスが登録されている場合登録ができないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'パスワードが空の場合登録ができないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'パスワードが５文字以下の場合登録ができないこと' do
        @user.password = 'aaa11'
        @user.password_confirmation = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードが半角数字のみの場合登録ができないこと' do
        @user.password = '11111'
        @user.password_confirmation = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英字と半角数字の両方を含めて設定してください')
      end

      it 'パスワードが半角英字のみの場合登録ができないこと' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英字と半角数字の両方を含めて設定してください')
      end

      it 'パスワード（確認用）が空の場合登録ができないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'パスワード（確認用）とパスワードが異なる場合登録ができないこと' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
