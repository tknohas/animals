# Our Pets

ご自身のペットを思う存分に投稿していただく写真投稿サイトです。
<br>
写真投稿に加え、動物と触れ合えるおすすめの施設をユーザーさんに登録していただくことでおすすめ施設を共有できます。
<br>
トップページにて、新着投稿とユーザーさんが登録した施設を地図上で確認することができます。

<img width="1440" alt="スクリーンショット 2023-10-10 23 26 10" src="https://github.com/tknohas/animals/assets/131782882/a9e37b08-4a52-439d-876a-a4cb8119dbf2">
<img width="545" alt="スクリーンショット 2023-10-13 1 08 08" src="https://github.com/tknohas/animals/assets/131782882/2f55264c-3f86-4ff9-9ea0-e9ff2d3b3c34">

# URL

https://our-pets-227cabb5c837.herokuapp.com/
<br>
ナビゲーションバーにあるゲストログインボタンから、メールアドレスとパスワードを入力せずにログインすることが可能です。

# 作成の背景

## 課題①
既存のSNSでは動物の投稿を検索しても動物以外の投稿が表示されてしまうことがある。  
→絞り込み機能を利用することで見たい動物を種類（ワンちゃんやネコちゃんなど）で絞り込むことができるように実装

## 課題②
動物と触れ合うことができる施設を知りたい。  
→ユーザーさんにそれぞれのおすすめ施設を投稿していただく機能を実装

## 課題③
思う存分自分のペットを自慢したい。  
→いいね数に囚われず載せたい写真を投稿できるよういいねの数を表示しないように実装

# 使用技術

- HTML
- CSS
- JavaScript
- JQuery
- Bootstrap
- Ruby 3.0.6
- Ruby on Rails 6.1.7
- Rspec
- Google Maps API
- HEROKU
- SQLite(development/test)
- PostgreSQL(production)



# 機能一覧

- ユーザー登録、ログイン機能(devise)
- 投稿機能
  - 画像投稿(Active Storage)
  - 施設の位置情報検索機能(geocoder)
- 画像スライド(bootstrap)
- いいね機能(Ajax)
- ページネーション機能(kaminari)
- 検索機能
- 絞り込み機能

# テスト
- Rspec
  - 単体テスト(model)
  - 統合テスト(system)
