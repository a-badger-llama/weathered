# frozen_string_literal: true

require "test_helper"

class ForecastTest < Minitest::Test
  include ForecastTestData

  attr_accessor :forecast

  def setup
    @forecast = Forecast.new(forecast_data, cached: false)
  end

  def test_current_temp
    expected = forecast_data.dig("current", "temp_f")

    assert_equal(expected, forecast.current_temp)
  end

  def test_future_days_is_array_of_forecast_days
    forecast.future_days.each do |day|
      assert_kind_of(Forecast::Day, day)
    end
  end

  class Forecast::DayTest < ForecastTest
    attr_accessor :forecast_day, :day_data

    def setup
      @day_data     = forecast_data.dig("forecast", "forecastday").first
      @forecast_day = Forecast::Day.new(day_data)

      super
    end

    def test_attr_assignment
      attrs = %i(day_data date average_temp max_temp min_temp hourly_data)

      attrs.each do |attr|
        assert(forecast_day.send(attr).present?)
      end
    end

    def test_get_hourly_data
      time = day_data["hour"].first["time"]
      temp = day_data["hour"].first["temp_f"]

      assert_equal([[time, temp]], forecast_day.get_hourly_data)
    end
  end
end
