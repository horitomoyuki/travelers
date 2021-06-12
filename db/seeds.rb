p "create Users"
User.create!(
  email: 'user1@gmail.com',
  password: 'abc123',
  name: 'エマ',
  introduction: '音楽と猫と美味しいものが好き！',
  gender: 1,
  country_id: 1,
  image: open("#{Rails.root}/db/dummy_images/1.jpg")
)
User.create!(
  email: 'user2@gmail.com',
  password: 'abc123',
  name: 'オリビア',
  introduction: 'クリエイターさんと話してみたい。',
  gender: 1,
  country_id: 1,
  image: open("#{Rails.root}/db/dummy_images/2.jpg")
)
User.create!(
  email: 'user3@gmail.com',
  password: 'abc123',
  name: 'エヴァ',
  introduction: 'プロフィールをご覧いただきありがとうございます。東京でWebマーケティング関連の仕事をしています。',
  gender: 1,
  country_id: 1,
  image: open("#{Rails.root}/db/dummy_images/3.jpg")
)
User.create!(
  email: 'user4@gmail.com',
  password: 'abc123',
  name: 'ノア',
  introduction: '東京で美容師をしています。',
  gender: 0,
  country_id: 1,
  image: open("#{Rails.root}/db/dummy_images/4.jpg")
)
User.create!(
  email: 'user5@gmail.com',
  password: 'abc123',
  name: 'リアム',
  introduction: '普段は公認会計士として働いています',
  gender: 0,
  country_id: 1,
  image: open("#{Rails.root}/db/dummy_images/5.jpg")
)
User.create!(
  email: 'user6@gmail.com',
  password: 'abc123',
  name: 'オリバー',
  introduction: '週3日くらい1人ラーメンします',
  gender: 0,
  country_id: 1,
  image: open("#{Rails.root}/db/dummy_images/6.jpg")
)
