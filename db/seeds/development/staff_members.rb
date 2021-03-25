StaffMember.create!(
  email: "taro@example.com",
  familiy_name: "山田",
  given_name: "太郎",
  familiy_name_kana: "ヤマダ",
  given_name_kana: "タロウ",
  password: "password",
  start_date: Date.today
)

familiy_names = %w{
  佐藤:サトウ:sato
  鈴木:鈴木:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
}

given_names = %w{
  二郎:ジロウ:jiro
  三郎:サブロウ:saburo
  松子:マツコ:matsuko
  竹子:タケコ:takeko
  梅子:ウメコ:umeko
}

20.times do |n|
  fn = familiy_names[n % 4].split(":")
  gn = given_names[n % 5].split(":")

  StaffMember.create!(
    email: "#{fn[2]}.#{gn[2]}@example.com",
    familiy_name: fn[0],
    given_name: gn[0],
    familiy_name_kana: fn[1],
    given_name_kana: gn[1],
    password: "password",
    start_date: (100 - n).days.ago.to_date,
    end_date: n == 0 ? Date.today : nil,
    suspended: n == 1
  )
end