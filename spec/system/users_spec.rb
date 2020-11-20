require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー新規登録' do
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
        expect {click_button '登録する'}.to_not change { User.count }
        expect(current_path).to eq '/users'
      end
    end
  end

  describe 'ログイン' do
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

    context 'ゲストログインのとき' do
      before do
        visit root_path
        expect(page).to have_content('ログイン')
        visit new_user_session_path
      end

      it 'ゲストユーザーとしてログインできること' do
        expect(page).to have_content('閲覧用')
        click_link '閲覧用'
        expect(current_path).to eq root_path
        expect(page).to have_content('ゲストユーザーとしてログインしました。')
      end

      it 'ゲスト管理者としてログインできること' do
        expect(page).to have_content('管理者用')
        click_link '管理者用'
        expect(current_path).to eq root_path
        expect(page).to have_content('ゲスト管理者としてログインしました。')
      end
    end
  end

  describe 'ユーザー情報編集' do
    context 'ゲストログインではないとき' do
      before do
        @user = FactoryBot.create(:user, nickname: '山田太郎', email: 'sample1@com')
      end

      it '編集ができること' do
        sign_in(@user)
        expect(find('.dropdown').click).to have_content('マイページ')
        visit user_path(@user)
        expect(page).to have_content('山田太郎')
        expect(page).to have_content('sample1@com')
        click_link '編集する'
        fill_in 'ニックネーム', with: '御村託也'
        fill_in 'メールアドレス', with: 'sample2@com'
        click_button '更新する'
        expect(current_path).to eq user_path(@user)
        expect(page).to have_content('アカウント情報を変更しました。')
        expect(page).to have_content('御村託也')
        expect(page).to have_content('sample2@com')
      end
    end

    context 'ゲストログインのとき' do
      before do
        @user = FactoryBot.create(:user, nickname: 'ゲストユーザー', email: 'user@example.com')
      end

      it '編集ができないこと' do
        visit new_user_session_path
        click_link '閲覧用'
        find('.dropdown-toggle').click
        click_link 'マイページ'
        expect(page).to have_content('ゲストユーザー')
        expect(page).to have_content('user@example.com')
        click_link '編集する'
        fill_in 'ニックネーム', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'user1@example.com'
        click_button '更新する'
        expect(current_path).to eq user_path(@user)
        expect(page).to have_content('ゲストユーザーは編集できません。')
        expect(page).to have_content('ゲストユーザー')
        expect(page).to have_content('user@example.com')
      end
    end
  end
end
