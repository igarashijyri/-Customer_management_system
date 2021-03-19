require 'rails_helper'

RSpec.describe StaffMember, type: :model do 
  describe "#password=" do
    example "文字列が与えられたとき、hashed_paswordは長さ60の文字列になる" do
      member = StaffMember.new
      member.password = "baukis"

      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size). to eq(60)
    end

    example "nilが与えられたとき、hashed_passwordはnilになる" do
      member = StaffMember.new(hashed_password: "x")
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
