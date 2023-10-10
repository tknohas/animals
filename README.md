# Our Pets

https://our-pets-227cabb5c837.herokuapp.com/

ご自身のペットを思う存分に投稿していただく写真投稿サイトです。
<br>
ペットの投稿だけでなく、動物と触れ合えるおすすめの施設をユーザーさんに登録していただくことでおすすめ施設を共有できます。

<img width="1440" alt="スクリーンショット 2023-10-10 23 26 10" src="https://github.com/tknohas/animals/assets/131782882/a9e37b08-4a52-439d-876a-a4cb8119dbf2">

ナビゲーションバーにあるゲストログインボタンから、メールアドレスとパスワードを入力せずにログインすることが可能です。

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
  - 施設の所在地表示(geocoder)
- 画像スライド(bootstrap)
- いいね機能(Ajax)
- ページネーション機能(kaminari)
- 検索機能
- 絞り込み機能

# テスト
- 単体テスト(model)
- 統合テスト(system)
