class Staff::TopController < Staff::Base
  skip_before_action :authorize
  skip_before_action :check_timeout

  def index
    render action: "index"
  end
end
