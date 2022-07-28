class TraceipController < ApplicationController

  def index
  end

  def search
    @traceip = Traceip.find_country(params[:ip])

    unless @traceip
      flash[:alert] = 'Country not found'
      return render action: :index
    end

    @traceip
  
  end



end
