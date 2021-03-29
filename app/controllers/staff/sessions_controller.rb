class Staff::SessionsController < Staff::Base
  skip_before_action :authorize
  skip_before_action :check_timeout

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)

    # TODO: Controllerにロジック書いてるの良くないのでモデルに書き出したい
    if @form.email.present?
      staff_member = StaffMember.find_by("LOWER(email) = ?", @form.email.downcase) 
    end

    # TODO: このif文、意図がわかりづらいからStaff::Authenticatorと合わせて修正したい
    # HACK: create!とかモデルで行うべき
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        staff_member.events.create!(type: "rejected")
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        session[:last_access_time] = Time.current
        staff_member.events.create!(type: "logged_in")
        flash.notice = "ログインしました。"
        redirect_to :staff_root 
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    # NOTE: すでにログアウトしている状態でdestroyが呼ばれる可能性があるため、ifで判断している
    if current_staff_member
      current_staff_member.events.create!(type: "logged_out") 
    end

    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました。"
    redirect_to :staff_root
  end

  private

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
