require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @user = FactoryBot.create(:user, nickname: 'たろう')
    @laundry = FactoryBot.create(:laundry)
  end
  context '投稿ができるとき' do
    it '内容を全て入力した場合コメント投稿ができる' do
      sign_in(@user)
      visit laundry_path(@laundry)
      # 投稿フォームを表示する
      find('.acd-label').click

      # フォームを入力
      choose 'comment_gender_1' #男性を選択
      select '20代', from: 'comment_age_id'
      select 'とても良い', from: 'comment_rate_id'
      fill_in '本文(必須)', with: 'とても清潔感がある店舗です。また行きます！'
      click_button '送信'
      #投稿フォームが空になっていること
      expect(page).to have_no_checked_field('comment_gender_1')
      expect(page).to have_no_checked_field('comment_gender_2')
      expect(page).to have_no_checked_field('comment_gender_3')
      expect(page).to have_select('comment_age_id', selected: '--')
      expect(page).to have_select('comment_rate_id', selected: '--')
      expect(find('.comment-text')).to have_no_content('とても清潔感がある店舗です。また行きます！')
      # 口コミが投稿されていること
      expect(find('.comment')).to have_content('とても清潔感がある店舗です。また行きます！')
      expect(find('.comment')).to have_content('とても良い')
      expect(find('.comment')).to have_content('たろう')
    end
  end
end
