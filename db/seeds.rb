# メインのサンプルユーザーを1人作成する
User.create!(name:  "kazu",
             email: "kazu@gmail.com",
             password:              "112233",
             password_confirmation: "112233",
             admin: true)

# 追加のユーザーをまとめて生成する
30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Platform.create!(name: "PC")
Platform.create!(name: "Switch")
Platform.create!(name: "Playstation")
Platform.create!(name: "Xbox")