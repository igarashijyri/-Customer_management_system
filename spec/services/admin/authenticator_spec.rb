require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticate" do

    example "正しいパスワードのとき、trueを返す" do
      administrator = build(:administrator)
      expect(Admin::Authenticator.new(administrator).authenticate("password")).to be_truthy
    end

    example "誤ったパスワードのとき、falseを返す" do
      administrator = build(:administrator)
      expect(Admin::Authenticator.new(administrator).authenticate("pw")).to be_falsey
    end

    example "パスワードが未設定のとき、falseを返す" do
      administrator = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(administrator).authenticate(nil)).to be_falsey
    end 

    example "停止フラグが立っていても、trueを返す" do
      administrator = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(administrator).authenticate("password")).to be_truthy
    end
  end
end