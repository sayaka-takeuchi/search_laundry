require 'rails_helper'

RSpec.describe '店舗情報登録', type: :system do
  context '管理者の場合' do
    before do
      @admin = FactoryBot.create(:user, admin: true)
    end
    it '店舗情報を登録する' do
      sign_in(@admin)
      expect(page).to have_link('登録')
      visit '/laundries/new'
      # 登録情報入力
      attach_file 'laundry_image', Rails.root.join('public/images/test_image.png')
      fill_in'laundry_name', with: 'コインランドリー南店'
      fill_in'laundry_address', with: '愛知県名古屋市南1-1'
      fill_in'laundry_opening_date', with: '002020-10-06'
      click_button '24時間営業'
      expect{click_button '登録'}.to change { Laundry.count}.by(1)
      expect(current_path).to eq root_path
      # トップページに登録情報が表示されているか確認
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content('コインランドリー南店')
      expect(page).to have_content('愛知県名古屋市南1-1')
      expect(page).to have_content('2020/10/06')
    end
  end
  context '管理者ではない場合' do
    before do
      @laundry = FactoryBot.create(:laundry)
      @user = FactoryBot.create(:user, admin: false)
    end
  
    it 'ログインしても登録ボタンが表示されない' do
      sign_in(@user)
      expect(page).to have_no_link('登録')
    end
  end
  context 'ログインしていない場合' do
    before do
      @laundry = FactoryBot.create(:laundry)
    end
    it '登録ボタンが表示されない' do
      visit root_path
      expect(page).to have_no_selector('.send-new-page')
    end
  end
end

RSpec.describe '店舗情報編集', type: :system do
  before do
    @admin = FactoryBot.create(:user, admin: true)
    @user = FactoryBot.create(:user, admin: false)
    @laundry = FactoryBot.create(
      :laundry, 
      name: 'コインランドリー１号店', 
      address: '愛知県名古屋市1-10', 
      opening_date: '2020-10-31',
      open_time: '7:00',
      close_time: '23:00',
      shoe_washing: true,
      futon_washing: true,
      dryer: true,
      washing_machine: true
    )
  end
  context '管理者の場合' do
    it '店舗情報の編集を行う' do
      sign_in(@admin)
      expect(page).to have_link('編集')
      visit edit_laundry_path(@laundry)
      # 編集ページに入力されているか確認
      expect(page).to have_field('laundry_name', with: 'コインランドリー１号店')
      expect(page).to have_field('laundry_address', with: '愛知県名古屋市1-10')
      expect(
        find('#laundry_opening_date').value
      ).to eq ('2020-10-31')
      expect(page).to have_select('laundry_open_time_4i', selected: '07')
      expect(page).to have_select('laundry_open_time_5i', selected: '00')
      expect(page).to have_select('laundry_close_time_4i', selected: '23')
      expect(page).to have_select('laundry_close_time_5i', selected: '00')
      expect(page).to have_checked_field('靴洗濯乾燥機')
      expect(page).to have_checked_field('布団洗濯乾燥機')
      expect(page).to have_checked_field('乾燥機')
      expect(page).to have_checked_field('洗濯機')
      # 内容の変更
      attach_file 'laundry_image', Rails.root.join('public/images/test_image2.png')
      fill_in'laundry_name', with: 'コインランドリー２号店'
      fill_in'laundry_address', with: '愛知県名古屋市1-20'
      fill_in'laundry_opening_date', with: '002020-10-06'
      select '05', from: 'laundry_open_time_4i'
      select '30', from: 'laundry_open_time_5i'
      select '00', from: 'laundry_close_time_4i'
      select '30', from: 'laundry_close_time_5i'
      uncheck '靴洗濯乾燥機'
      uncheck '布団洗濯乾燥機'
      uncheck '乾燥機'
      uncheck '洗濯機'
      click_button '登録'
      expect(current_path).to eq  laundry_path(@laundry)
      # 詳細ページの内容が変更されているか確認
      expect(page).to have_selector("img[src$='test_image2.png']")
      expect(page).to have_content('コインランドリー２号店') 
      expect(page).to have_content('愛知県名古屋市1-20') 
      expect(page).to have_content('2020/10/06') 
      expect(page).to have_content('5:30') 
      expect(page).to have_content('0:30') 
      expect(page.all('td')[4]).to have_content '×'
      expect(page.all('td')[5]).to have_content '×'
      expect(page.all('td')[6]).to have_content '×'
      expect(page.all('td')[7]).to have_content '×'
    end
  end
  context '管理者ではない場合' do
    it'編集ボタンが表示されない' do
      sign_in(@user)
      expect(page).to have_no_link('編集')
    end 
  end
  context 'ログインしていない場合' do
    it'編集ボタンが表示されない' do
      visit root_path
      expect(page).to have_no_link('編集')
    end
  end
end

RSpec.describe '店舗情報削除', type: :system do
  before do
    @admin = FactoryBot.create(:user, admin: true)
    @user = FactoryBot.create(:user, admin: false)
    @laundry = FactoryBot.create(
      :laundry, 
      name: 'コインランドリー１号店', 
      address: '愛知県名古屋市1-10', 
      opening_date: '2020-10-31'
    )
  end
  context '管理者の場合' do 
    it '店舗情報の削除ができる' do
      sign_in(@admin)
      expect(page).to have_content('コインランドリー１号店')
      expect(page).to have_content('愛知県名古屋市1-10')
      expect(page).to have_content('2020/10/31')
      click_link '削除'
      expect {
        page.accept_confirm '削除を実行します。よろしければOKをクリックしてください。'
        expect(page).to have_content '削除が完了しました'
      }.to change { Laundry.count }.by(-1)
      expect(page).to have_no_content('コインランドリー１号店')
      expect(page).to have_no_content('愛知県名古屋市1-10')
      expect(page).to have_no_content('2020/10/31')
    end
    it '店舗情報の削除をやめる' do
      sign_in(@admin)
      click_link '削除'
      expect {
        page.dismiss_confirm '削除を実行します。よろしければOKをクリックしてください。'
        }.to_not change { Laundry.count }
      expect(page).to have_content('コインランドリー１号店')
      expect(page).to have_content('愛知県名古屋市1-10')
      expect(page).to have_content('2020/10/31')
    end
  end     
  context '管理者ではない場合' do
    it'削除ボタンが表示されない' do
      sign_in(@user)
      expect(page).to have_no_link('削除')
    end 
  end
  context 'ログインしていない場合' do
    it'削除ボタンが表示されない' do
      visit root_path
      expect(page).to have_no_link('削除')
    end
  end
end

RSpec.describe '店舗情報詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @laundry = FactoryBot.create(
    :laundry, 
    name: 'コインランドリー１号店', 
    address: '愛知県名古屋市1-10', 
    opening_date: '2020-10-31',
    open_time: '7:00',
    close_time: '23:00',
    shoe_washing: true,
    futon_washing: true,
    dryer: false,
    washing_machine: false
  )
  end
  context 'ログインユーザーの場合' do
    it '詳細ページにコメント投稿フォームが表示される' do
      sign_in(@user)
      expect(find('.image').hover).to have_link('詳細を見る')
      visit laundry_path(@laundry)
      # 詳細ページに店舗情報の内容が含まれている
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content('コインランドリー１号店') 
      expect(page).to have_content('愛知県名古屋市1-10') 
      expect(page).to have_content('2020/10/31') 
      expect(page).to have_content('7:00') 
      expect(page).to have_content('23:00') 
      expect(page.all('td')[4]).to have_content '○'
      expect(page.all('td')[5]).to have_content '○'
      expect(page.all('td')[6]).to have_content '×'
      expect(page.all('td')[7]).to have_content '×'
      # 地図が表示されている
      expect(page).to have_selector '#map'
      #投稿フォームが表示されている
      expect(page).to have_content('口コミを投稿する')
    end
  end
  context '未ログインユーザーの場合' do
    it '詳細ページにコメント投稿フォームが表示されていない' do
      visit root_path
      expect(find('.image').hover).to have_link('詳細を見る')
      visit laundry_path(@laundry)
      #投稿フォームが表示されていない
      expect(page).to have_content('ログインユーザーのみ口コミ投稿ができます。')
    end
  end
end