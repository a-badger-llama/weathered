# frozen_string_literal: true

require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  include ForecastTestData

  def test_index
    get(forecasts_path)

    refute(response.body.include?("Today's forecast"))
  end

  def test_index_with_postal_code
    Rails.cache.clear

    Net::HTTP.expects(:get)
             .with(request_uri)
             .returns(forecast_data.to_json)
             .once

    get(
      forecasts_path,
      params: {
        postal_code: 84009
      }
    )

    assert(response.body.include?("Today's forecast"))
    refute(response.body.include?("*pulled from cached weather data within the last 30 minutes"))

    get(
      forecasts_path,
      params: {
        postal_code: 84009
      }
    )

    assert(response.body.include?("*pulled from cached weather data within the last 30 minutes"))
  end
end
