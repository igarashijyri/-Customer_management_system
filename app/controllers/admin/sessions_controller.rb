class Admin::SessionsController < Admin::Base
  skip_before_action :authorize
  
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)

    # TODO: Controllerにロジック書いてるの良くないのでモデルに書き出したい
    if @form.email.present?
      administrator = Administrator.find_by("LOWER(email) = ?", @form.email.downcase) 
    end

    # TODO: フォームからemailの値が送られなかった場合にundifind_method_errorになると思われるので、確認&修正が必要
    # TODO: このif文、意図がわかりづらいからStaff::Authenticatorと合わせて修正したい
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:administrator_id] = administrator.id
        session[:admin_last_access_time] = Time.current
        flash.notice = "ログインしました。"
        redirect_to :admin_root 
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました。"
    redirect_to :admin_root
  end

  private

  def login_form_params
    params.require(:admin_login_form).permit(:email, :password)
  end
end
