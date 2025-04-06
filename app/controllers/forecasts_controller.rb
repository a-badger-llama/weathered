class ForecastsController < ApplicationController
  def index
    @postal_code = params[:postal_code]

    @forecast = Forecast.new(cache_or_fetch_forecast(@postal_code)) if @postal_code
  end

  def create
    cache_or_fetch_forecast(params[:postal_code])

    redirect_to action: :index, params: { postal_code: params[:postal_code] }
  end

  private

  def cache_or_fetch_forecast(postal_code)
    Rails.cache.fetch("#{postal_code}/forecast", expires_in: 30.minutes) do
      Forecasts::Create.run(postal_code)
    end
  end
end
