require 'rails_helper'

RSpec.describe 'Laundries', type: :request do
  describe '#index' do
    it '正常にレスポンスを返すこと' do
      get root_path
      expect(response).to be_successful
      expect(response).to have_http_status '200'
    end
  end

  describe '#show' do
    before do
      @laundry = FactoryBot.create(:laundry)
    end

    it '正常にレスポンスを返すこと' do
      get laundry_path(@laundry)
      expect(response).to be_successful
    end
  end

  describe '#new' do
    context '管理者の場合' do
      before do
        @user = FactoryBot.create(:user, admin: true)
      end

      it '正常にレスポンスを返すこと' do
        sign_in @user
        get new_laundry_path
        expect(response).to be_successful
      end
    end

    context '認可されていないユーザーの場合' do
      before do
        @user = FactoryBot.create(:user, admin: false)
      end

      it 'トップページにリダイレクトすること' do
        sign_in @user
        get new_laundry_path
        expect(response).to redirect_to root_path
      end
    end

    context 'ゲストユーザーの場合' do
      it '302レスポンスを返すこと' do
        get new_laundry_path
        expect(response).to have_http_status '302'
      end

      it 'トップページにリダイレクトすること' do
        get new_laundry_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#create' do
    context '管理者の場合' do
      before do
        @user = FactoryBot.create(:user, admin: true)
      end

      context "有効な属性値の場合" do
        it '店舗情報を追加できること' do
          laundry_params = FactoryBot.attributes_for(:laundry, image: fixture_file_upload('/files/test_image.png'))
          sign_in @user
          expect {
            post laundries_path, params: { laundry: laundry_params }
          }.to change { Laundry.count }.by(1)
        end
      end

      context "無効な属性値の場合" do
        it "店舗情報を登録できないこと" do
          laundry_params = FactoryBot.attributes_for(:laundry, :invalid)
          sign_in @user
          expect {
            post laundries_path, params: { laundry: laundry_params }
          }.to_not change { Laundry.count }
        end
      end
    end

    context '認可されていないユーザーの場合' do
      before do
        @user = FactoryBot.create(:user, admin: false)
      end

      it '店舗情報を追加できないこと' do
        laundry_params = FactoryBot.attributes_for(:laundry, image: fixture_file_upload('/files/test_image.png'))
        sign_in @user
        expect {
          post laundries_path, params: { laundry: laundry_params }
      }.to_not change { Laundry.count }
      end

      it 'トップページにリダイレクトすること' do
        laundry_params = FactoryBot.attributes_for(:laundry, image: fixture_file_upload('/files/test_image.png'))
        sign_in @user
        post laundries_path, params: { laundry: laundry_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'ゲスト(未ログインユーザー)の場合' do
      it '302レスポンスを返すこと' do
        laundry_params = FactoryBot.attributes_for(:laundry, image: fixture_file_upload('/files/test_image.png'))
        post laundries_path, params: { laundry: laundry_params }
        expect(response).to have_http_status '302'
      end
    end
  end

  describe '#edit' do
    context '管理者の場合' do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @laundry = FactoryBot.create(:laundry)
      end

      it '正常にレスポンスを返すこと' do
        sign_in @user
        get edit_laundry_path(@laundry)
        expect(response).to be_successful
      end
    end

    context '認可されていないユーザーの場合' do
      before do
        @user = FactoryBot.create(:user, admin: false)
        @laundry = FactoryBot.create(:laundry)
      end

      it 'トップページにリダイレクトすること' do
          sign_in @user
          get edit_laundry_path(@laundry)
          expect(response).to redirect_to root_path
      end
    end

    context 'ゲストユーザーの場合' do
      before do
        @laundry = FactoryBot.create(:laundry)
      end

      it '302レスポンスを返すこと' do
        get edit_laundry_path(@laundry)
        expect(response).to have_http_status '302'
      end

      it 'トップページにリダイレクトすること' do
        get edit_laundry_path(@laundry)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#update' do
    context '管理者の場合' do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @laundry = FactoryBot.create(:laundry, name: 'コインランドリー名古屋店')
      end

      context "有効な属性値の場合" do
        it '店舗情報を更新できること' do
          laundry_params = FactoryBot.attributes_for(:laundry, 
            name: 'コインランドリー岡崎店', 
            image: fixture_file_upload('/files/test_image.png'))
          sign_in @user
          patch laundry_path(@laundry), params: { laundry: laundry_params }
          expect(@laundry.reload.name).to eq 'コインランドリー岡崎店'
        end
      end
      
      context '無効な属性値の場合' do
        it '店舗情報を更新できないこと'
          laundry_params = FactoryBot.attributes_for(:laundry, :invalid)
          sign_in @user
          expect {
            patch laundry_path(@laundry), params: { laundry: :invalid }
          }.to_not change { Laundry.count }
        end
      end
    end

    context '認可されていないユーザーの場合' do
      before do
        @user = FactoryBot.create(:user, admin: false)
        @laundry = FactoryBot.create(:laundry, name: 'コインランドリー名古屋店')
      end

      it '店舗情報を更新できないこと' do
        laundry_params = FactoryBot.attributes_for(:laundry, 
          name: 'コインランドリー岡崎店', 
          image: fixture_file_upload('/files/test_image.png'))
        sign_in @user
        patch laundry_path(@laundry), params: { laundry: laundry_params }
        expect(@laundry.reload.name).to eq 'コインランドリー名古屋店'
      end
    end

    context 'ゲスト(未ログインユーザー)の場合' do
      before do
        @laundry = FactoryBot.create(:laundry, name: 'コインランドリー名古屋店')
      end

      it '302レスポンスを返すこと' do
        laundry_params = FactoryBot.attributes_for(:laundry, 
          name: 'コインランドリー岡崎店', 
          image: fixture_file_upload('/files/test_image.png'))
        patch laundry_path(@laundry), params: { laundry: laundry_params }
        expect(response).to have_http_status '302'
      end

      it 'トップページにリダイレクトすること' do
        laundry_params = FactoryBot.attributes_for(:laundry, 
          name: 'コインランドリー岡崎店', 
          image: fixture_file_upload('/files/test_image.png'))
        patch laundry_path(@laundry), params: { laundry: laundry_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#destroy' do
    context '管理者の場合' do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @laundry = FactoryBot.create(:laundry)
      end

      it '店舗情報を削除できること' do
        sign_in @user
        expect {
          delete laundry_path(@laundry)
      }.to change { Laundry.count }.by(-1)
      end
    end

    context '認可されていないユーザーの場合' do
      before do
        @user = FactoryBot.create(:user, admin: false)
        @laundry = FactoryBot.create(:laundry)
      end

      it '店舗情報を削除できないこと' do
        sign_in @user
        expect {
          delete laundry_path(@laundry)
        }.to_not change { Laundry.count }
      end

      it 'トップページにリダイレクトすること' do
        sign_in @user
        delete laundry_path(@laundry)
        expect(response).to redirect_to root_path
      end
    end

    context 'ゲスト(未ログインユーザー)の場合' do
      before do
        @laundry = FactoryBot.create(:laundry)
      end

      it '302レスポンスをかえすこと' do
        delete laundry_path(@laundry)
        expect(response).to have_http_status '302'
      end

      it 'トップページにリダイレクトすること' do
        delete laundry_path(@laundry)
        expect(response).to redirect_to root_path
      end

      it '店舗情報を削除できないこと' do
        expect {
          delete laundry_path(@laundry)
        }.to_not change { Laundry.count }
      end
    end
  end
end
