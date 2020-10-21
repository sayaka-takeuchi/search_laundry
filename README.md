## 名前
- search_laundry
## 概要
- コインランドリーの検索アプリケーションです。詳細ボタンをクリックすると各店舗の詳細をみることができます。

## 機能一覧
- 店舗検索機能
- 店舗一覧表示機能
- 店舗にコメントをつける機能
- 地図表示機能
- 店舗情報登録機能(以下管理者限定機能)
- 店舗削除機能
- 店舗情報編集機能
- 口コミ投稿機能

## 使用技術
- ruby 2.6.5
- Ruby on Rails 6.0.3.
- MySQL
- AWS(EC2)
- AWS(S3)
- GoogleMapAPI
    - Maps JavaScript API
    - Geocoding API
    
## URL 
- - URL http://54.95.238.12/
## アカウント情報
- Basic認証　ID arscute / Pass 0915
- テストログイン(管理者) email test@com
- Password: aaaa1111

## ER図
![search_laundry-ER図](https://user-images.githubusercontent.com/70420209/96695848-1662f080-13c5-11eb-8aa6-c7078f0c39f9.jpg)

## ローカルでの動作方法
% git clone https://github.com/sayaka0915/search_laundry.git<br>
% cd search_laundry<br>
% bundle install<br>
% yarn install<br>
% rails db:create<br>
% rails db:migrate<br>
% rails db:seed<br>
% rails s<br>
👉 http://localhost:3000<br>
