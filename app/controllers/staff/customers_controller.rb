class Staff::CustomersController < Staff::Base
  def index
    @customers = Customer.order(:familiy_name_kana, :given_name_kana).page(params[:page])
  end
end
