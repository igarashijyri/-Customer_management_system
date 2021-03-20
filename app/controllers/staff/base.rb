class Staff::Base < ApplicationController
  private

  # HACK session[:staff_member_id]がnilなら、findの結果もnilになると思うのでif文自体撤去していいかも
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find(session[:staff_member_id])
    end
  end

  helper_method :current_staff_member
end