## 名前
- search_laundry
## 概要
- コインランドリーの検索アプリケーションです。店舗情報の画像クリックすることで各店舗の詳細をみることができます。
![60964c699d0befae695383ec3748c7ba (1)](https://user-images.githubusercontent.com/70420209/99045722-21c8c680-25d5-11eb-9c94-fcedc4fc96be.jpg)

## 機能一覧
- 店舗検索機能(ransack)
- 店舗一覧表示機能
- 店舗詳細情報表示機能
- 口コミ投稿機能(Ajax)
- 地図表示機能(GoogleMapAPI)
- ユーザー登録、ログイン機能(devise)
- ページネーション機能(kaminari)

#### 管理者限定機能
- 店舗情報登録機能
- 店舗削除機能
- 店舗情報編集機能
- 一覧表示機能(店舗一覧、登録ユーザー一覧、コメント一覧)
- コメント一覧出力機能（CSV）

## 使用技術
フロントエンド
- Bootstrap
- JavaScript

バックエンド
- Ruby 2.6.5
- Rails 6.0.3.3

本番環境
- AWS(EC2、S3)
- MySQL2
- Nginx、 Puma

その他
- GoogleMapAPI
- Maps JavaScript API
- Geocoding API
- RSpec
    
## URL 
- http://18.181.25.177/<br>
ログインページに遷移していただいた後に閲覧用または管理者用リンクをクリックしていただくことでテストユーザーとしてログインできます。

## ER図
![search_laundry-ER図 ](https://user-images.githubusercontent.com/70420209/99046676-70c32b80-25d6-11eb-8521-8f867f248f18.jpg)
