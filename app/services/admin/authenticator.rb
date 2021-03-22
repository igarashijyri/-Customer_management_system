class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  # TODO: 条件分岐を他のメソッドに切り分けたい
  # TODO: 真偽値を返すメソッドは末尾に "?" をつける方向で統一したい
  def authenticate(raw_password)
    @administrator &&
      @administrator.hashed_password &&
      BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end
