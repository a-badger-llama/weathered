require "net/https"

module Forecasts
  class Create
    attr_accessor :request, :response

    def initialize(postal_code)
      @request = build_request postal_code
    end

    def self.run(postal_code)
      new(postal_code).run
    end

    def run
      @response = JSON.parse Net::HTTP.get(request)
    end

    private

    def build_request(postal_code)
      URI::HTTPS.build(
        host:  "api.weatherapi.com",
        path:  "/v1/current.json",
        query: URI.encode_www_form(
          key: ENV["WEATHER_API_KEY"],
          q:   postal_code,
        )
      )
    end
  end
end
