class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  TIMEOUT = 60.minute

  private

  # HACK session[:staff_member_id]がnilなら、findの結果もnilになると思うのでif文自体撤去していいかも
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find(session[:staff_member_id])
    end
  end

  def authorize
    unless current_staff_member
      flash.alert = "職員としてログインしてください。"
      redirect_to :admin_login
    end
  end

  # HACK: checkという命名はよくない
  # HACK: unlessにしてtryメソッドを使えば単純化できそう
  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash_alert = "アカウントが無効になりました"
      redirect_to :staff_root
    end
  end

  def check_timeout
    if current_staff_member
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_acceess_time] = Time.current
      else
        session.delete(:staff_member_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :staff_login
      end
    end
  end

  helper_method :current_staff_member
end