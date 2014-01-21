require 'net/http'
class Tracker

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :tracking_number, :information

  validates :tracking_number, :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def track
    track_fedex(tracking_number)
  end

  def track_fedex tracking_number
    begin
      @fedex ||= Fedex::Shipment.new(key: "e7hchnqJyRbXYuk3",
                               password:"ebHRlMJlq1pC4t6BNnphdmuHI",
                               account_number: "510087321",
                               meter:"100200352",
                               mode: "development")
      self.information = @fedex.track(tracking_number: tracking_number).first

    rescue Exception => e
      errors.add(:tracking_number, e.message)
    end
  end


  def track_dhl tracking_number

    url = URI.parse("http://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=en&idc=217703557591&extendedSearch=true")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    puts res.body
   response_html = Nokogiri::HTML(res.body)

  end

end