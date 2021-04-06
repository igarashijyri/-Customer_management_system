class CustomerFormPresenter < UserFormPresenter
  def gender_field_block
    markup(:div, class: "radio-buttons") do |m|
      m << decorated_label(:gender, "性別")
      m << radio_button(:gender, "male")
      m << label(:gender_male, "男性")
      m << radio_button(:gender, "famale")
      m << label(:gender_famale, "女性")
    end
  end
end