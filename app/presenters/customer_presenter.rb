class CustomerPresenter < ModelPresenter
  delegate :email, to: :object

  def full_name
    object.familiy_name + " " + object.given_name
  end

  def full_name_kana
    object.familiy_name_kana + " " + object.given_name_kana
  end

  def birthday
    return "" if object.birthday.blank?
    object.birthday.strftime("%Y%m%d")
  end

  def gender
    case object.gender
    when "male"
      "男性"
    when "famale"
      "女性"
    else
      ""
    end
  end
end