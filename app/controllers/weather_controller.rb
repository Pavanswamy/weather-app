class WeatherController < ApplicationController
  def index
    if params[:address].present?
      @forecast = WeatherInfoService.get_forecast(params[:address])
    end
  end
end
