require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticate" do

    example "正しいパスワードのとき、trueを返す" do
      staff_member = build(:staff_member)
      expect(Staff::Authenticator.new(staff_member).authenticate("password")).to be_truthy
    end

    example "誤ったパスワードのとき、falseを返す" do
      staff_member = build(:staff_member)
      expect(Staff::Authenticator.new(staff_member).authenticate("pw")).to be_falsey
    end

    example "パスワードが未設定のとき、falseを返す" do
      staff_member = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(staff_member).authenticate(nil)).to be_falsey
    end

    example "停止フラグが立っていても、trueを返す" do
      staff_member = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(staff_member).authenticate("password")).to be_truthy
    end

    example "開始前のとき、falseを返す" do
      staff_member =  build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(staff_member).authenticate("password")).to be_falsey
    end

    example "終了後のとき、falseを返す" do
      staff_member = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(staff_member).authenticate("password")).to be_falsey
    end
  end
end