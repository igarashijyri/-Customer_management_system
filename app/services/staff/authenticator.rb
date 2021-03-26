class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  # TODO: 条件分岐を他のメソッドに切り分けたい
  # TODO: 真偽値を返すメソッドは末尾に "?" をつける方向で統一したい
  def authenticate(raw_password)
    @staff_member &&
      @staff_member.hashed_password &&
      @staff_member.start_date <= Date.today &&
      (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end
