class TrackingController < ApplicationController

  def index
    fedex = Fedex::Shipment.new(key: "e7hchnqJyRbXYuk3",
                             password:"ebHRlMJlq1pC4t6BNnphdmuHI",
                             account_number: "510087321",
                             meter:"100200352",
                             mode: "development")
  end

  def new

  end

  def search

  end

end
