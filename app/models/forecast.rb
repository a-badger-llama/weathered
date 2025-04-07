# frozen_string_literal: true

class Forecast
  attr_accessor :cached, :current, :forecast_data, :future_days
  delegate :current_temp, to: :current

  def initialize(forecast_data, cached: false)
    @forecast_data = forecast_data
    @cached        = cached
  end

  def current_temp
    @current_temp ||= forecast_data.dig("current", "temp_f")
  end

  def future_days
    future_days = forecast_data.dig("forecast", "forecastday")

    @future_days ||= future_days.map { |day_data|
      Day.new(day_data)
    }
  end

  class Day
    attr_accessor :day_data,
                  :date,
                  :average_temp,
                  :max_temp,
                  :min_temp,
                  :hourly_data

    def initialize(day_data)
      @day_data     = day_data
      @date         = day_data["date"]
      @average_temp = day_data.dig("day", "avgtemp_f")
      @max_temp     = day_data.dig("day", "maxtemp_f")
      @min_temp     = day_data.dig("day", "mintemp_f")
      @hourly_data  ||= get_hourly_data
    end

    def get_hourly_data
      day_data["hour"].map { |hour|
        [hour["time"], hour["temp_f"]]
      }
    end
  end
end
