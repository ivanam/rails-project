require "uri"
require "net/http"

class Currency < ApplicationRecord
    has_many :countries


    def convert
        url = URI("https://api.apilayer.com/fixer/convert?to=USD&from=#{self.code}&amount=1")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request['apikey'] = ENV.fetch("API_KEY_LAYER")

        response = https.request(request)
        puts JSON.parse(response.read_body)["result"]

        JSON.parse(response.read_body)["result"]
    end

end
