class StaffMember < ApplicationRecord
  has_many :events, class_name: "StaffEvent", dependent: :destroy

  def password=(raw_password)
    # TODO: 文字列でもnilでもない値が渡ったときにエラーとする処理を書いた方がいい
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
