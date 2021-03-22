class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])

    # TODO: Controllerにロジック書いてるの良くないのでモデルに書き出したい
    if @form.email.present?
      staff_member = StaffMember.find_by("LOWER(email) = ?", @form.email.downcase) 
    end

    # TODO: フォームからemailの値が送られなかった場合にundifind_method_errorになると思われるので、確認&修正が必要
    # TODO: このif文、意図がわかりづらいからStaff::Authenticatorと合わせて修正したい
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = "ログインしました。"
        redirect_to :staff_root 
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました。"
    redirect_to :staff_root
  end
end
