# frozen_string_literal: true

require "test_helper"

class CreateTest < Minitest::Test
  include ForecastTestData

  def test_run
    Rails.cache.clear

    Net::HTTP.expects(:get)
             .with(request_uri)
             .returns(forecast_data.to_json)
             .once

    forecast = Forecasts::Create.run(84009)
    assert_instance_of(Forecast, forecast)
    refute(forecast.cached)

    cached_forecast = Forecasts::Create.run(84009)
    assert(cached_forecast.cached)
  end

  def test_weather_api_returns_error
    Rails.cache.clear

    Net::HTTP.expects(:get)
             .with(request_uri)
             .returns(error_response.to_json)
             .once

    forecast = Forecasts::Create.run(84009)
    assert_instance_of(Hash, forecast)
    refute(forecast[:cached])

    cached_forecast = Forecasts::Create.run(84009)
    assert(cached_forecast[:cached])
  end
end
