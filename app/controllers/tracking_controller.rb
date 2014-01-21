class TrackingController < ApplicationController


  def new
    @tracker = Tracker.new
  end

  def search
    @tracker = Tracker.new(params[:tracker])
    if @tracker.valid?
      @tracker.track
    end
  end

end
