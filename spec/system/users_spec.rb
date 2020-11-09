require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに遷移すること' do
      # トップページに移動
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード(半角英数字混合６文字以上)', with: @user.password
      fill_in 'パスワード（確認用）', with: @user.password_confirmation
      fill_in 'user_first_name', with: @user.first_name
      fill_in 'user_last_name', with: @user.last_name
      fill_in 'user_first_name_kana', with: @user.first_name_kana
      fill_in 'user_last_name_kana', with: @user.last_name_kana
      # 登録を行う
      expect {click_button '登録する'}.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content('アカウント登録が完了しました。')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報を入力したときユーザー新規登録ができずに新規登録ページに戻ってくること' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'ニックネーム', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード(半角英数字混合６文字以上)', with: ''
      fill_in 'パスワード（確認用）', with: ''
      fill_in 'user_first_name', with: ''
      fill_in 'user_last_name', with: ''
      fill_in 'user_first_name_kana', with: ''
      fill_in 'user_last_name_kana', with: ''
      expect {click_button '登録する'}.to_not change { User.count }
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができること' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_button 'ログインする'
      expect(current_path).to eq root_path
      expect(page).to have_content('ログインしました。')
    end
  end
  context 'ログインができないとき' do
    it '誤った情報を入力すればユーザー新規登録ができずに新規登録ページに戻ってくること' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログインする'
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content('Eメールまたはパスワードが違います。')
    end
  end
end
