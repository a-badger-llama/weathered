ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module ForecastTestData
  attr_accessor :error_response, :forecast_data, :request_uri

  private

  def request_uri
    @request_uri ||= URI::HTTPS.build(
      host:  "api.weatherapi.com",
      path:  "/v1/forecast.json",
      query: URI.encode_www_form(
        key:  ENV["WEATHER_API_KEY"],
        q:    84009,
        days: 3,
        )
    )
  end

  def error_response
    @error_response ||= {
      "error" => {
        "code"    => 1006,
        "message" => "No matching location found."
      }
    }
  end

  def forecast_data
    @forecast_data ||= {
      "current"  => {
        "temp_f" => 51
      },
      "forecast" => {
        "forecastday" => [{
                            "date" => "2025-04-07",
                            "day"  => {
                              "avgtemp_f" => 50,
                              "maxtemp_f" => 60,
                              "mintemp_f" => 40
                            },
                            "hour" => [
                              {
                                "time"   => "2025-04-07 00:00",
                                "temp_f" => 45
                              }
                            ]
                          }]
      }
    }
  end
end
