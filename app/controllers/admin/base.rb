class Admin::Base < ApplicationController

  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  TIMEOUT = 60.minutes

  private

  # HACK session[:administrator_id]がnilなら、findの結果もnilになると思うのでif文自体撤去していいかも

  # HACK Staff::Baseとやっていること一緒なので、もう１つ上にBaseを作成して、そこにメソッドを昇格しても良いかも
  # 少なくとも共通化はしたい
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find(session[:administrator_id])
    end
  end

  def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end

  # HACK: checkという命名はよくない
  def check_account
    if current_administrator && current_administrator.suspended?
      session.delete(:administrator_id)
      flash.alert = "アカウントが無効になりました"
      redirect_to :admin_root
    end
  end

  def check_timeout
    if current_administrator
      if session[:admin_last_access_time] >= TIMEOUT.ago
        session[:admin_last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :admin_login
      end
    end
  end
  helper_method :current_administrator
end