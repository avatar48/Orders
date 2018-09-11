class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  def check_status_job
    ps = Sidekiq::ProcessSet.new
    @status = Sidekiq::Status::at params[:job_id]
    response = {sidekiq_status: ps.size, procent_comlite: @status}
    render json: response
  end

end
