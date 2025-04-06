class Forecast
  attr_accessor :forecast_data,
                :current_temp

  def initialize(forecast_data)
    @forecast_data = forecast_data
  end

  def current_temp
    @current_temp ||= forecast_data.dig("current", "temp_f")
  end
end
