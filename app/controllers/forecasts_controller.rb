# frozen_string_literal: true

class ForecastsController < ApplicationController
  attr_accessor :postal_code

  before_action :set_postal_code

  def index
    return unless postal_code

    @forecast = Forecasts::Create.run(postal_code)
  end

  private

  def set_postal_code
    @postal_code ||= params["postal_code"]
  end
end
