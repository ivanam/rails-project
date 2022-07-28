require 'uri'
require 'net/http'
require 'openssl'

class Traceip < ApplicationRecord
    belongs_to :country, optional: true
    has_many :country_currencies

    after_create :create_country
    after_create :create_currency

    LAT_BSAS=-34.61315
    LONG_BSAS=-58.37723

    def self.create_with(hash)
        traceip = create(ip: hash["ip"], extra_data: hash)
        traceip.distance = distance(hash["latitude"].to_i,hash["longitude"].to_i, LAT_BSAS, LONG_BSAS)
        traceip.save
        traceip
    end

    def self.request_api(url, headers)
        response = Excon.get(url,headers: {})
        return nil if response.status != 200
        JSON.parse(response.body)
    end
    
    def self.find_country(ip)
        trace_db = Traceip.find_by(ip: ip)
        return trace_db if trace_db.present?
        response_hash = request_api(
            "http://api.ipapi.com/#{ip}?access_key=cb9a413e03265fad2c69b1d3a30cc08e",
             nil
            )
        create_with(response_hash) if response_hash.present?
    end
    

    def create_country
      self.country = Country.create!(
        name: self.extra_data["country_name"], 
        code: self.extra_data["country_code"],
        languages: self.extra_data["location"]["languages"]
        )
      self.save
    end

    def create_currency
        return nil if hash.nil?
        hash = self.find_currencies
        currency = Currency.create!(code: hash["code"], name: hash["name"]) unless Currency.find_by(code: hash["code"]).present?
        self.country.update_columns(currency_id: currency.id)
    end

    def self.distance(lat1, lon1, lat2, lon2)
        return 0 if (lat1 == lat2) && (lon1 == lon2)
        
        theta = lon1 - lon2
        dist = Math.sin(lat1 * Math::PI / 180) * Math.sin(lat2 * Math::PI / 180) + Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) * Math.cos(theta * Math::PI / 180)
        dist = Math.acos(dist)
        dist = dist * 180 / Math::PI
        miles = dist * 60 * 1.1515
  
        return miles * 1.609344

    end

    def find_currencies
        url = URI("https://ip-geo-location4.p.rapidapi.com/?ip=#{ip}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(url)
        request["X-RapidAPI-Key"] = 'ffe0efb45fmshc85b76ec7137d02p1f6977jsnfbf78b59e600'
        request["X-RapidAPI-Host"] = 'ip-geo-location4.p.rapidapi.com'
        
        response = http.request(request)
        JSON.parse(response.read_body)["currency"]
    
    end
    
end

