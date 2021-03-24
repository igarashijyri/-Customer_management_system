class Admin::StaffMembersController < Admin::Base
  def index
    @staff_members = StaffMember.order(:familiy_name_kana, :given_namae_kana)
  end
end
