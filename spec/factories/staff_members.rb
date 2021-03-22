FactoryBot.define do
  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com"}
    familiy_name { "山田" }
    given_name { "太郎" }
    familiy_name_kana { "ヤマダ" }
    given_name_kana { "タロウ" }
    password { "password" }
    start_date { Date.yesterday }
    end_date { nil }
    suspended { false }
  end
end
