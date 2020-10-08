require 'rails_helper'

RSpec.describe Laundry, type: :model do
  before do
    @laundry = FactoryBot.build(:laundry)
  end

  describe '店舗新規登録' do
    context '店舗情報が保存できる場合' do
      it '画像、店名、住所、オープン日、営業時間が入力されていれば保存ができること' do
       expect(@laundry).to be_valid
      end

      it '店舗の特徴(靴選択乾燥機)を選択していなくても登録ができること' do
       @laundry.shoe_washing = false
       expect(@laundry).to be_valid
      end
 
      it '店舗の特徴(布団選択乾燥機)を選択していなくても登録ができること' do
        @laundry.futon_washing = false
        expect(@laundry).to be_valid 
      end

      it '店舗の特徴(乾燥機)を選択していなくても登録ができること' do
        @laundry.dryer = false
        expect(@laundry).to be_valid
      end
 
      it '店舗の特徴(洗濯機)を選択していなくても登録ができること' do
        @laundry.washing_machine = false
        expect(@laundry).to be_valid 
      end 
    end

    context '店舗情報の保存ができない場合' do
      it '画像が空の場合登録ができないこと' do
        @laundry.image = nil
        @laundry.valid?
        expect(@laundry.errors.full_messages).to include('画像を入力してください')
      end

      it '店舗名が空の場合登録ができないこと' do
        @laundry.name = nil
        @laundry.valid?
        expect(@laundry.errors.full_messages).to include('店名を入力してください')
      end

      it '店舗住所が空の場合登録ができないこと' do
        @laundry.address = nil
        @laundry.valid?
        expect(@laundry.errors.full_messages).to include('店舗住所を入力してください')
      end

      it 'オープン日が空の場合登録ができないこと' do
        @laundry.opening_date = nil
        @laundry.valid?
        expect(@laundry.errors.full_messages).to include('オープン日を入力してください')
      end

      it '営業時間(開店時間)が空の場合登録ができないこと' do
        @laundry.open_time = nil
        @laundry.valid?
        expect(@laundry.errors.full_messages).to include('営業時間(開店時間)を入力してください')
      end

      it '営業時間(閉店時間)が空の場合登録ができないこと' do
        @laundry.close_time = nil
        @laundry.valid?
        expect(@laundry.errors.full_messages).to include('営業時間(閉店時間)を入力してください')
      end
    end
  end
end