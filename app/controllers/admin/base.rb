class Admin::Base < ApplicationController

  private

  # HACK session[:administrator_id]がnilなら、findの結果もnilになると思うのでif文自体撤去していいかも

  # HACK Staff::Baseとやっていること一緒なので、もう１つ上にBaseを作成して、そこにメソッドを昇格しても良いかも
  # 少なくとも共通化はしたい
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find(session[:administrator_id])
    end
  end

  helper_method :current_administrator
end