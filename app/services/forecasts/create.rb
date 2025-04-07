require "net/https"

module Forecasts
  class Create
    attr_accessor :postal_code, :request, :response

    def initialize(postal_code)
      @postal_code = postal_code
      @request     = build_request postal_code
    end

    def self.run(postal_code)
      new(postal_code).run
    end

    def run
      cache_key = "#{postal_code}/forecast"
      cached    = Rails.cache.exist?(cache_key)

      @response = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        get_response
      end

      Forecast.new(response, cached: cached)
    end

    private

    def get_response
      JSON.parse Net::HTTP.get(request)
    end

    def build_request(postal_code)
      URI::HTTPS.build(
        host:  "api.weatherapi.com",
        path:  "/v1/forecast.json",
        query: URI.encode_www_form(
          key:  ENV["WEATHER_API_KEY"],
          q:    postal_code,
          days: 3,
          aqi:  "yes",
        )
      )
    end
  end
end
