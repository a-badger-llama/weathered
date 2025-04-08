# frozen_string_literal: true

class ForecastsController < ApplicationController
  def index
    @postal_code = params["postal_code"]

    return unless @postal_code

    @forecast = Forecasts::Create.run(@postal_code)

    unless @forecast.is_a?(Forecast)
      @error    = @forecast[:error]
      @forecast = nil
      @cached = @error["cached"]
    end

    @cached ||= @forecast.try(:cached) || false
  end
end
