
Platform.create!(name: "PC")
Platform.create!(name: "Switch")
Platform.create!(name: "Playstation")
Platform.create!(name: "Xbox")

# メインのサンプルユーザーを1人作成する
User.create!(name:  "kazu",
             email: "kazu@gmail.com",
             password:              "112233",
             password_confirmation: "112233",
             platform_ids: [1,2],
             admin: true)

User.create!(name:  "other",
             email: "other@gmail.com",
             password:              "112233",
             platform_ids:[1],
             password_confirmation: "112233")

User.create!(name:  "ig",
             email: "ig@gmail.com",
             password:              "112233",
             platform_ids:[3],
             password_confirmation: "112233")