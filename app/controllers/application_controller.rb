class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def by_period
    if params[:year] && params[:month]
      @period = Period.where(month: params[:month], year: params[:year]).first!
      session[:period_id] = @period.id
    elsif session[:period_id]
      @period = Period.find(session[:period_id])
    else
      @period = Period.current
    end

    @prev_period = @period.prev
    @next_period = @period.next
  end
end
