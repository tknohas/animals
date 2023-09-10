# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
animal = Genre.create(name:  'みなさんのペットたち')

dog, cat, small_animal = animal.children.create(
  [
    { name: 'ワンちゃん' },
    { name: 'ネコちゃん' },
    { name: '小動物・ほか' }
  ]
)

['トイプードル', 'ミニチュアダックスフンド',  'ボーダーコリー', 'シェットランドシープドッグ',  'チワワ',  '柴犬',  'パグ',  'ミニチュアダックスフンド',  'ゴールデンレトリバー',  'その他'].each do |name|
  dog.children.create(name: name)
end

['マンチカン', 'ロシアンブルー',  'アメリカンショートヘア', 'スコティッシュフォールド',  'ラグドール',  'サイベリアン',  'ベンガル',  'その他'].each do |name|
  cat.children.create(name: name)
end

['うさぎ', 'ハムスター',  'フェレット', 'トリ',  'トカゲ',  'ヘビ', 'サル', '観賞魚', 'カメ'  'その他'].each do |name|
  small_animal.children.create(name: name)
end


Tag
Tag.create([
    { name: 'ワンちゃん' },
    { name: 'ネコちゃん' },
    { name: '小動物'},
    { name: '観賞魚'},
    { name: '爬虫類・ほか'},
    ])
